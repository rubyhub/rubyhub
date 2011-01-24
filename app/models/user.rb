class User < ActiveRecord::Base
  belongs_to :city
  has_one :blog
  has_one :twitter_account

  #validates_presence_of :provider, :uid

  attr_protected :provider, :uid

  after_save :clear_cities_cache

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth['user_info']['email']
    end
  end

protected
  def clear_cities_cache
    Rails.cache.delete(:cities_for_map) if city_id_changed?
  end
end
