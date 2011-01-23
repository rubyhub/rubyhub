class User < ActiveRecord::Base
  belongs_to :city, :counter_cache => true
  has_many :blogs
  has_many :twitter_accounts

  validates_presence_of :provider, :uid

  attr_protected :provider, :uid

  after_update :update_counter_cache

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth['user_info']['email']
    end
  end

private
  def update_counter_cache
    if city_id_changed?
      [city_id_was, city_id].compact.each do |id|
        c=City.find(id)
        c.update_attributes!(:users_count => c.users.count)
      end
    end
  end
end
