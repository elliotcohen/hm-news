class Upvote
  include Mongoid::Document
  include Mongoid::Timestamps
  
  #relationships
  belongs_to :user
  belongs_to :news_item
  
end