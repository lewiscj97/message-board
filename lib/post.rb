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
end
