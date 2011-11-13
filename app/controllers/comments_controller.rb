# encoding: utf-8

class CommentsController < ApplicationController
  before_filter :find_comment, :only => [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.xml
  def create
    params[:comment][:user] = User.find(params[:comment][:user])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    # params[:comment][:user] = User.find(params[:comment][:user])
    # post = Post.find(params[:comment][:post])
    # params[:comment][:post] = post
    # @comment = Comment.new(params[:comment])
    # puts params[:comment].inspect
    
    if @comment.save
      redirect_to @post, :notice => "Комментарий успешно создан."
    else
      # puts @comment.errors.messages.inspect
      # redirect_to post, :alert => "При создании комментария возникла проблема."
      redirect_to @post, :alert => "Проблема при создании комментария: " + @comment.errors.messages[:content].first.to_s
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    respond_to do |wants|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        wants.html { redirect_to(@comment) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment.destroy
    redirect_to :back, :notice => "Ваш комментарий был успешно удален."
  end

  private
    def find_comment
      @comment = Comment.find(params[:id])
    end

end