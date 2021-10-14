feature 'Message Board' do
  scenario 'Submitting a first post' do
    visit('/posts/new')
    fill_in 'name', with: 'Lewis Jones'
    fill_in 'message', with: 'This is my first message!'
    click_button 'Submit'

    expect(page).to have_current_path '/posts'
    expect(page).to have_content 'Lewis Jones'
    expect(page).to have_content 'This is my first message!'
  end

  scenario 'viewing posts already added' do
    connection = PG.connect(dbname: 'message_board_test')
    connection.exec("INSERT INTO posts(name, message) VALUES('Lewis Jones', 'This is an interesting first note');")
    connection.exec("INSERT INTO posts(name, message) VALUES('Foo', 'This is my lovely second note');")

    visit('/posts')
    
    expect(page).to have_content 'Lewis Jones'
    expect(page).to have_content 'This is an interesting first note'

    expect(page).to have_content 'Foo'
    expect(page).to have_content 'This is my lovely second note'
  end

  scenario 'able to create a new post from the main page' do
    visit('/posts')

    click_button('New Post')

    expect(page).to have_current_path '/posts/new'
  end

  scenario 'is told there are no posts yet' do
    visit('/posts')

    expect(page).to have_content 'There are no posts yet!'
  end

  scenario 'is able to click button to view posts from /posts/new' do
    connection = PG.connect(dbname: 'message_board_test')
    connection.exec("INSERT INTO posts(name, message) VALUES('Lewis Jones', 'This is an interesting first note');")

    visit('/posts/new')

    click_button('View Posts')

    expect(page).to have_content 'Lewis Jones'
    expect(page).to have_content 'This is an interesting first note'
  end

  scenario 'user sees most recent posts first' do
    connection = PG.connect(dbname: 'message_board_test')
    connection.exec("INSERT INTO posts(name, message) VALUES('Lewis', 'This is an interesting first note');")
    connection.exec("INSERT INTO posts(name, message) VALUES('Ana', 'This is my second note');")

    visit('/posts')
    
    expect(page).to have_content "Ana\nThis is my second note\nLewis\nThis is an interesting first note"
  end
end

feature 'comments' do
  scenario 'user is able to comment on a post' do
    connection = PG.connect(dbname: 'message_board_test')
    connection.exec("INSERT INTO posts(name, message) VALUES('Foo', 'This is a message');")

    result = connection.exec("SELECT * FROM posts;")
    post = Post.find(result.first['id'])

    visit('/posts')

    within("section[@id=\"#{post.id}\"]") do
      click_button('Comment')
    end

    fill_in 'name', with: 'Bar'
    fill_in 'comment', with: 'This is my comment'
    click_button 'Submit'

    data = connection.exec("SELECT * FROM comments;")
    expect(data.first['name']).to eq 'Bar'
    expect(data.first['comment']).to eq 'This is my comment'
  end

  scenario 'user is able to view comments on a post' do
    connection = PG.connect(dbname: 'message_board_test')
    connection.exec("INSERT INTO posts(name, message) VALUES('Foo', 'This is a message');")

    result = connection.exec("SELECT * FROM posts;")
    post = Post.find(result.first['id'])

    connection.exec("INSERT INTO comments(name, comment, message_id) VALUES('Bar', 'This is a comment', '#{post.id}');")

    visit('/posts')

    expect(page).to have_content 'Bar'
    expect(page).to have_content 'This is a comment'
  end
end