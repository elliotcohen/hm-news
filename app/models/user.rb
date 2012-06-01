class User
  include Mongoid::Document
  include Mongoid::Timestamps

  #relationships
  has_many :comments
  has_many :news_items
  has_many :upvotes

  #fields
  field :provider, :type => String
  field :uid, :type => String
  field :name, :type => String
  field :email, :type => String
  field :about, :type => String
  field :karma, :type => Integer
  attr_accessible :provider, :uid, :name, :email
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
         user.about = ""
         user.karma = 1
      end
    end
  end
  
  def upvoted?(item)
    return Upvote.where(:user_id => self.id, :item_id => item.id).count > 0
  end

end

