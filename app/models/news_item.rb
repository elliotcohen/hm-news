class NewsItem
  include Mongoid::Document
  include Mongoid::Timestamps
  
  #relationships
  has_many :comments
  belongs_to :user
  has_many :upvotes
  
  #fields
  field :title, :type => String
  field :url, :type => String
  field :text, :type => String
  field :score, :type => Integer, :default => 0
  
  #validations
  validates_presence_of :title, :message => "You must include a title"
  validates_format_of :url, :with => URI::regexp, :message => "please enter a valid URL", :on => :create, :allow_blank => true
  validate :url_or_text, :message => "You must include a URL or text but not both"

  #scopes
  scope :highest, :order_by => [ :score, :desc ]
  scope :latest, :order_by => [ :created_at, :desc ]
  
  def upvote(user)
    v = Upvote.new(:user => user, :news_item => self)
    if v.save
      self.score += user.karma
      if self.save
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
  protected 
    
  #validation functions
  def url_or_text
    if (not (self.url.blank? || self.text.blank?) && (not (self.url.blank? && self.text.blank?)))
      errors.add(:url, "you must include a URL or text but not both")
      errors.add(:text, "you must include a URL or text but not both")
    end
  end

  
end