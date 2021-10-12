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
end
