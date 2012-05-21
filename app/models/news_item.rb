class NewsItem
  include Mongoid::Document
  include Mongoid::Timestamps
  
  #relationships
  has_many :comments
  belongs_to :user
  
  #fields
  field :title, :type => String
  field :url, :type => String
  field :text, :type => String

  
end