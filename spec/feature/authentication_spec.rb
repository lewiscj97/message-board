feature 'authentication' do

  scenario 'user asked to sign up or sign in at index' do
    visit('/')
    
    expect(page).to have_button 'Sign up'
    expect(page).to have_button 'Sign in'
  end

  scenario 'able to create a new user' do
    visit('/sign_up')

    fill_in 'username', with: 'foo'
    fill_in 'password', with: 'password'
    click_button 'Submit'

    expect(page).to have_current_path '/posts'

    connection = PG.connect(dbname: 'message_board_test')
    response = connection.exec("SELECT * FROM users;")
    
    user = response.first

    expect(user['name']).to eq 'foo'
    expect(user['password']).to eq 'password'
  end

  scenario 'able to sign in' do
    connection = PG.connect(dbname: 'message_board_test')
    response = connection.exec("INSERT INTO users(name, password) VALUES('testing', 'password');")

    visit('/sign_in')

    fill_in 'username', with: 'testing'
    fill_in 'password', with: 'password'
    click_button 'Submit'

    expect(page).to have_current_path '/posts'
  end

  scenario "unable to sign in if details don't exist" do
    visit('/sign_in')

    fill_in 'username', with: 'testing'
    fill_in 'password', with: 'password'
    click_button 'Submit'

    expect(page).to have_current_path '/sign_in'
  end
end
