# Message Board
## Setup

1. Clone repo
2. Run `bundle install`
3. Will also need to create databases with the correct structure:

- Database name: `message_board`

- Table name: `posts`

- Contents: 

|id|name|message|
|--|----|-------|

- Set-up a test database (`message_board_test`) with the same table and contents.

## To run

- Run `rackup -p 4567`
- Navigate to `localhost:4567/posts` to use the application