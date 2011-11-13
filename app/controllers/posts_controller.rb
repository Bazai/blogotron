# encoding: utf-8

class PostsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:show]
  
  def index
    @posts = Post.find_all_by_user_id(current_user)
    # redirect_to blogs_path + "/" + current_user.id.to_s
    # redirect_to current_user.blog_url
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    params[:post][:user] = User.find(params[:post][:user])
    @post = Post.new(params[:post])
    if @post.save
      redirect_to @post, :notice => "Запись успешно создана."
    else
      render :action => 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to root_path, :alert => "Только автор может редактировать свои записи" unless @post.user == current_user
  end

  def update
    user = User.find(params[:post][:user])
    params[:post][:user] = user
    @post = Post.find(params[:id])
    redirect_to root_path, :alert => "Только автор может обновлять свои записи" unless @post.user == current_user
    if @post.update_attributes(params[:post])
      redirect_to @post, :notice  => "Запись успешно обновлена."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    redirect_to root_path, :alert => "Только автор может удалять свои записи" unless @post.user == current_user
    @post.destroy
    redirect_to posts_url, :notice => "Запись успешно удалена."
  end
  
  def add_comment
    
  end
end
