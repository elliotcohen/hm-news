class Content
  include Mongoid::Document
  include Mongoid::Timestamps
  
  #associations
  belongs_to :user
  has_many :upvotes
  
  #fields
  field :text, :type => String
  field :score, :type => Integer, :default => 0
  
  validates :user_id, :presence => true
  
  def upvote(user)
    v = Upvote.new(:user => user, :item => self)
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
  
end
