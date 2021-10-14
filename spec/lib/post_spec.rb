require 'post'

describe Post do
  describe '#create' do
    it 'returns a new Post object' do
      post = Post.create('Lewis Jones', 'This is my first message!')
      expect(post.name).to eq 'Lewis Jones'
      expect(post.message).to eq 'This is my first message!'
    end

    it 'adds the name and message to the test database' do
      post = Post.create('Lewis Jones', 'This is my first message!')
      
      connection = PG.connect(dbname: 'message_board_test')
      response = connection.exec('SELECT * FROM posts;')
      expect(response.first['name']).to eq post.name
      expect(response.first['message']).to eq post.message
    end
  end

  describe "#all" do
    it "returns all the posts as Post objects" do
      post = Post.create('Lewis Jones', 'This is my first message!')
      
      response = Post.all
      expect(response.first.id).to eq post.id
      expect(response.first.name).to eq post.name
      expect(response.first.message).to eq post.message
    end
  end

  describe "#find" do
    it "returns a post object when passed the post_id" do
      connection = PG.connect(dbname: 'message_board_test')
      connection.exec("INSERT INTO posts(name, message) VALUES('Lewis', 'Messages');")
      
      data = connection.exec("SELECT * FROM posts;")
      post_id = data.first['id']

      post = Post.find(post_id)

      expect(post.name).to eq 'Lewis'
      expect(post.message).to eq 'Messages'
    end
  end
end
