def reset_test_database
  # connect to test DB and clear it
  connection = PG.connect(dbname: 'message_board_test')
  connection.exec('TRUNCATE posts;')
  connection.exec('TRUNCATE comments;')
  connection.exec('TRUNCATE users;')
end