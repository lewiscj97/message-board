require 'comment'
require 'post'

decribe Comment do
  describe '#create' do
    it 'lets the user create a new comment on a post' do
      post = Post.create('Lewis Jones', 'This is my first message!')
      post_id = post.id
      comment = Comment.create('Foo', 'This is a comment', post_id)
      
      expect(comment.name).to eq 'Foo'
      expect(comment.comment).to eq 'This is a comment'
      expect(comment.post_id).to eq post_id
    end
  end
end