class Comment < Content
  include Mongoid::Tree
  
  belongs_to :news_item
  
  def news_item
    if self.news_item_id.nil?
      return NewsItem.where(:_id => self.root.news_item_id).first
    else
      return NewsItem.where(:_id => self.news_item_id).first
    end
  end
end