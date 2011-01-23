class User < ActiveRecord::Base
  validates_presence_of :provider, :uid

  attr_protected :provider, :uid

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
    end
  end
end
