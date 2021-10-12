require 'sinatra'

class MessageBoard < Sinatra::Base
  get '/' do
    "Hello World!"
  end

  get '/posts/new' do
    erb(:new_post)
  end
end
