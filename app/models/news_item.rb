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
  
  #validations
  validates_presence_of :title, :message => "You must include a title"
  validate :url_or_text, :message => "You must include a URL or text but not both"
  
  protected 
    
  #validation functions
  def url_or_text
    return (self.url.nil? || self.text.nil?) && (not (self.url.nil? && self.text.nil?))
  end

  
end