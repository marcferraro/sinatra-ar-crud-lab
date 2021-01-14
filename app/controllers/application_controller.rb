
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do

    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles/new' do
    @article = Article.create(title: params[:title], content: params[:content])
    redirect "/articles/#{@article.id}"
  end

  #show
  get '/articles/:id' do |id|
    # binding.pry
    @article = Article.find(id)

    erb :show
  end

  #edit
  get "/articles/:id/edit" do |id|

    @article = Article.find(id)

    erb :edit
  end

  #update
  patch "/articles/:id" do |id|
    article = Article.find(id)
    params.delete("_method")
    article.update(params)
    redirect "/articles/#{article.id}"
  end
  
  #delete
  delete "/articles/:id" do |id|
    Article.find(id).delete

    redirect "/articles"
  end
  
end
