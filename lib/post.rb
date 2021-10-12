class Post
  attr_reader :name, :message

  def initialize(name, message)
    @name = name
    @message = message
  end

  def self.create(name, message)
    Post.new(name, message)
  end
end
