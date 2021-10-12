require 'pg'

class Post
  attr_reader :id, :name, :message

  def initialize(id, name, message)
    @id = id
    @name = name
    @message = message
  end

  def self.create(name, message)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect :dbname => 'message_board_test'
    else
      # :nocov:
      connection = PG.connect :dbname => 'message_board'
      # :nocov:
    end

    result = connection.exec("INSERT INTO posts(name, message) VALUES('#{name}', '#{message}') RETURNING id, name, message;")
    post = Post.new(result.first['id'], result.first['name'], result.first['message'])
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect :dbname => 'message_board_test'
    else
      # :nocov:
      connection = PG.connect :dbname => 'message_board'
      # :nocov:
    end

    response = connection.exec("SELECT * FROM posts;")
    response.map { |post| Post.new(post['id'], post['name'], post['message']) }
  end
end
