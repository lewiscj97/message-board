require 'comment'
require 'post'

describe Comment do
  describe '#create' do
    it 'lets the user create a new comment on a post' do
      connection = PG.connect(dbname: 'message_board_test')
      connection.exec("INSERT INTO posts(name, message) VALUES('Lewis Jones', 'This is my first message!');")

      data = connection.exec("SELECT * FROM posts;")

      post_id = data.first['id']
      
      comment = Comment.create('Foo', 'This is a comment', post_id)
      
      expect(comment.name).to eq 'Foo'
      expect(comment.comment).to eq 'This is a comment'
      expect(comment.post_id).to eq post_id
    end
  end

  describe '#get_comments_by_post_id' do
    it 'returns the comments associated with a specific post' do
      # add post into posts relation
      connection = PG.connect(dbname: 'message_board_test')
      connection.exec("INSERT INTO posts(name, message) VALUES('Lewis', 'This is an interesting first note');")

      # get posts
      data = connection.exec("SELECT * FROM posts;")

      # get post id
      post_id = data.first['id']

      # create some comments
      Comment.create('Foo', 'This is a comment', post_id)
      Comment.create('Bar', 'This is another comment', post_id)

      # get comments by id, returning an array of comment objects
      comments = Comment.get_comments_by_post_id(post_id)

      first_comment = comments[0]
      second_comment = comments[1]

      expect(first_comment.name).to eq 'Foo'
      expect(first_comment.comment).to eq 'This is a comment'

      expect(second_comment.name).to eq 'Bar'
      expect(second_comment.comment).to eq 'This is another comment'
    end
  end
end
