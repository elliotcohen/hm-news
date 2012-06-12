class CommentsController < ApplicationController
  before_filter :authenticate_user!, :only => [ :new, :create ]
  
  def show
    @comment = Comment.where(:_id => params[:id]).first
  end
  
  def new
    @comment = Comment.new
  end
  
  def new_child
    @comment = Comment.where(:_id => params[:comment_id]).first
    @child = @comment.children.new
  end
  
  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      respond_to do |format|
        format.json { render :status => 200, :json => @comment}
        format.html { redirect_to @comment}
      end
    else
      respond_to do |format|
        format.json { render :status => 406, :json => @comment.errors}
        format.html { render :new }
      end
    end
  end
  
  def create_child
    @comment = Comment.where(:_id => params[:comment_id]).first
    @child = @comment.children.new(params[:comment])
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @comment }
        format.json { render :status => 200, :json => @child }
      end
    else
      respond_to do |format|
        format.html { render :new_child }
        format.json { render :status => 406, :json => @child.errors }
      end
    end
  end
  
  def upvote
    @comment = Comment.where(:_id => params[:comment_id]).first
    if @comment.upvote(current_user)
      respond_to do |format|
        format.json { render :status => 200, :json => "success"}
      end
    else
      respond_to do |format|
        format.json { render :status => 500, :json => "failed"}
      end
    end
  end

end