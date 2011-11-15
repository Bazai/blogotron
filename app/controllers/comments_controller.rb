# encoding: utf-8

class CommentsController < ApplicationController
  before_filter :find_comment, :only => [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    params[:comment][:user] = User.find(params[:comment][:user])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    
    if @comment.save
      redirect_to @post, :notice => "Комментарий успешно создан."
    else
      redirect_to @post, :alert => "Проблема при создании комментария: " + @comment.errors.messages[:content].first.to_s
    end
  end

  def update
    if @comment.update_attributes(params[:comment])
      redirect_to @comment, :notice => "Комментарий был успешно обновлен"
    else
      render :action => "edit"
    end
  end

  def destroy
    @comment.destroy
    redirect_to :back, :notice => "Ваш комментарий был успешно удален."
  end

  private
    def find_comment
      @comment = Comment.find(params[:id])
    end

end