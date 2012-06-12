class NewsItem < Content
  
  #relationships
  has_many :comments
  
  #fields
  field :title, :type => String
  field :url, :type => String
  
  #validations
  validates_presence_of :title, :message => "You must include a title"
  validates_format_of :url, :with => URI::regexp, :message => "please enter a valid URL", :on => :create, :allow_blank => true
  validate :url_or_text, :message => "You must include a URL or text but not both"

  #scopes
  scope :highest, :order_by => [ :score, :desc ]
  scope :latest, :order_by => [ :created_at, :desc ]
  
  def top_level_comments
    return self.comments
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