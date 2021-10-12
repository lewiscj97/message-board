require 'sinatra'
require './lib/post'

class MessageBoard < Sinatra::Base
  get '/' do
    "Hello World!"
  end

  get '/posts/new' do
    erb(:new_post)
  end

  post '/new_post' do
    Post.create(params[:name], params[:message])
    redirect('/posts')
  end

  get '/posts' do
    erb(:posts)
  end
end
