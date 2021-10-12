require 'pg'

class Post
  attr_reader :name, :message

  def initialize(name, message)
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

    connection.exec("INSERT INTO posts(name, message) VALUES('#{name}', '#{message}');")
    Post.new(name, message)
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
    response.map { |post| Post.new(post['name'], post['message']) }
  end
end
