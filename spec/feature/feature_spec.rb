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
    Post.create('Lewis Jones', 'This is an interesting first note')
    Post.create('Foo', 'This is my lovely second note')

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
end
