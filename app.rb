require 'sinatra'

class MessageBoard < Sinatra::Base
  get '/' do
    "Hello World!"
  end
end
