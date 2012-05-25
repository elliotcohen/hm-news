class NewsItemsController < ApplicationController
  before_filter :authenticate_user!, :only => [ :new, :create, :upvote ]
  
  def index
    @news_items = NewsItem.highest.paginate(:page => params[:page])
  end
  
  def latest
    @news_items = NewsItem.latest.paginate(:page => params[:page])
    render :index
  end
  
  def show
    @news_item = NewsItem.where(:_id => params[:id]).first
  end
  
  def new
    @news_item = NewsItem.new
  end
  
  def upvote
    @news_item = NewsItem.where(:_id => params[:news_item_id]).first
    if @news_item.upvote(current_user)
      respond_to do |format|
        format.json { render :status => 200, :json => "success"}
      end
    else
      respond_to do |format|
        format.json { render :status => 500, :json => "failed"}
      end
    end
  end
  
  def create
    @news_item = NewsItem.new(params[:news_item])
    if @news_item.save
      redirect_to @news_item
    else
      render :new
    end
  end
end