class User < ActiveRecord::Base
  belongs_to :city
  has_many :blogs
  has_many :twitter_accounts

  validates_presence_of :provider, :uid

  attr_protected :provider, :uid

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth['user_info']['email']
    end
  end
end
