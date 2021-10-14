require 'sinatra'
require './lib/post'
require './lib/comment'
require './lib/user'

class MessageBoard < Sinatra::Base
  enable :sessions

  get '/' do
    erb(:index)
  end
  
  get '/sign_up' do
    erb(:sign_up)
  end

  get '/sign_in' do
    erb(:sign_in)
  end

  post '/authenticate' do
    result = User.authenticate(params[:username], params[:password])
    if result
      session[:user] = params[:username]
      redirect('/posts')
    else
      redirect('/sign_in')
    end
  end

  post '/new_user' do
    User.create(params[:username], params[:password])
    session[:user] = params[:username]
    redirect('/posts')
  end
  
  get '/posts' do
    p session[:user]
    @posts = Post.all
    erb(:posts)
  end
  
  get '/posts/new' do
    erb(:new_post)
  end

  post '/new_post' do
    Post.create(params[:name], params[:message])
    redirect('/posts')
  end

  get '/:id/comment' do
    @post = Post.find(params[:id])
    erb(:comment)
  end

  post '/:id/new_comment' do
    Comment.create(params['name'], params['comment'], params['id'])
    redirect('/posts')
  end
end
