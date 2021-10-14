require 'user'

describe User do
  describe "#create" do
    it 'creates a new user with a password' do
      User.create('testing', 'password')

      connection = PG.connect(dbname: 'message_board_test')
      response = connection.exec("SELECT * FROM users;")
      
      user = response.first

      expect(user['name']).to eq 'testing'
      expect(user['password']).to eq 'password'
    end
  end

  describe "#authenticate" do
    it 'returns true when the details match' do
      connection = PG.connect(dbname: 'message_board_test')
      connection.exec("INSERT INTO users(name, password) VALUES('lewis','testing');")

      expect(User.authenticate('lewis', 'testing')).to eq true
    end
  end
end