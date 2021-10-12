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
end