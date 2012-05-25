class CommentsController < ApplicationController
  before_filter :authenticate_user!, :only => [ :new, :create ]
  
  def show
    @comment = Comment.where(:_id => params[:id]).first
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to @comment
    else
      render :new
    end
  end
end