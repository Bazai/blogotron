# encoding: utf-8

class PostsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :find_and_check_post_owner, :only => [:edit, :update, :destroy]
  
  def index
    @user = User.find(params[:user_id]) unless params[:user_id].blank?
    # @user не пустая, значит запросили /users/:id/posts. Нет - значит запросили /posts
    @user ? @posts = Post.where("user_id = #{@user.id}").ordered : @posts = Post.ordered
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(params[:post])
    if @post.save
      redirect_to @post, :notice => "Запись успешно создана."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(params[:post])
      redirect_to @post, :notice  => "Запись успешно обновлена."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, :notice => "Запись успешно удалена."
  end
  
  private
  def find_and_check_post_owner
    @post = Post.find(params[:id])
    redirect_to root_path, :alert => "Только автор может управлять своими записями" unless @post.user == current_user
  end
end
