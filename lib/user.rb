require 'pg'

class User
  def self.create(name, message)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect :dbname => 'message_board_test'
    else
      # :nocov:
      connection = PG.connect :dbname => 'message_board'
      # :nocov:
    end

    connection.exec_params("INSERT INTO users(name, password) VALUES($1, $2);", [name, message])
  end

  def self.authenticate(name, password)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect :dbname => 'message_board_test'
    else
      # :nocov:
      connection = PG.connect :dbname => 'message_board'
      # :nocov:
    end

    result = connection.exec_params("SELECT * FROM users WHERE name=$1;", [name])
    
    result.first['password'] == password ? true : false
  end
end
