require 'pg'

class Comment
  attr_reader :id, :name, :comment, :post_id
  
  def initialize(id, name, comment, post_id)
    @id = id
    @name = name
    @comment = comment
    @post_id = post_id
  end

  def self.create(name, comment, post_id)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect :dbname => 'message_board_test'
    else
      # :nocov:
      connection = PG.connect :dbname => 'message_board'
      # :nocov:
    end

    result = connection.exec_params(
      "INSERT INTO comments(name, comment, message_id)
      VALUES($1, $2, $3) RETURNING id, name, comment, message_id;", [name, comment, post_id]
    )
    comment = Comment.new(result.first['id'], result.first['name'], result.first['comment'], result.first['message_id'])
  end

  def self.get_comments_by_post_id(post_id)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect :dbname => 'message_board_test'
    else
      # :nocov:
      connection = PG.connect :dbname => 'message_board'
      # :nocov:
    end

    result = connection.exec_params(
      "SELECT comments.id, comments.name, comment, message_id
      FROM comments
      JOIN posts ON comments.message_id=posts.id
      WHERE message_id=$1
      ORDER BY comments.id DESC;", [post_id]
    )
    
    result.map { | comment | Comment.new(comment['id'], comment['name'], comment['comment'], comment['message_id']) }
  end
end
