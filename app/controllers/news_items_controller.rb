class NewsItemsController < ApplicationController
  before_filter :authenticate_user!, :only => [ :new, :create ]
  
  def index
    @news_items = NewsItem.highest.paginate(:page => params[:page])
  end
  
  def latest
    @news_items = NewsItem.latest.paginate(:page => params[:page])
  end
  
  def show
    @news_item = NewsItem.where(:_id => params[:id]).first
  end
  
  def new
    @news_item = NewsItem.new
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