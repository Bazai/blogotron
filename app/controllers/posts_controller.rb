# encoding: utf-8

class PostsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:show, :index]
  
  def index
    # Запросили /users/:id/posts
    unless params[:user_id].blank?
      @user = User.find(params[:user_id])
      unless @user.blank?
        @posts = Post.find_all_by_user_id(@user)
      end
      render "user_posts"
    # Запросили /posts
    else
      @posts = Post.all(:order => "updated_at DESC")
      render "posts_feed"
    end
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
end
