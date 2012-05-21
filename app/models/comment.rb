class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  #relationships
  has_many :comments
  belongs_to :parent, :class_name => :comment
  belongs_to :news_item
  belongs_to :user
  
  #fields
  field :text, :type => String
  
end