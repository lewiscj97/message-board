feature 'authentication' do
  scenario 'able to create a new user' do
    visit('/')

    fill_in 'username', with: 'foo'
    fill_in 'password', with: 'password'

    expect(page).to have_current_path '/posts'

    connection = PG.connect(dbname: 'message_board_test')
    response = connection.exec("SELECT * FROM users;")
    
    user = response.first

    expect(user['name']).to eq 'testing'
    expect(user['password']).to eq 'password'
  end
end
