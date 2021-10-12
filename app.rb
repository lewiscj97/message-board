require 'sinatra'
require './lib/post'

class MessageBoard < Sinatra::Base
  get '/posts/new' do
    erb(:new_post)
  end

  post '/new_post' do
    Post.create(params[:name], params[:message])
    redirect('/posts')
  end

  get '/posts' do
    @posts = Post.all
    erb(:posts)
  end
end
