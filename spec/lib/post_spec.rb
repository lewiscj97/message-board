require 'post'

describe Post do
  describe '#create' do
    it 'returns a new Post object' do
      post = Post.create('Lewis Jones', 'This is my first message!')
      expect(post.name).to eq 'Lewis Jones'
      expect(post.message).to eq 'This is my first message!'
    end
  end
end