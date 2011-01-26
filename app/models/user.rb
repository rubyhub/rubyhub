class User < ActiveRecord::Base
  belongs_to :city
  has_one :blog
  has_one :twitter_account
  has_one :github_account
  has_one :linked_in_account

  enum_attr :gender, %w{male female}

  RELATIONS = %w{fulltime parttime hobbyist newbie interested ex coworker employer none}
  OSES = ['Linux', 'OS X', 'Windows']
  EDITORS = ['Vim','emacs','TextMate','NetBeans', 'RubyMine', 'Aptana'].sort

  enum_attr :tabs_or_spaces, %w(tabs spaces)

  #validates_presence_of :provider, :uid
  validates :birth_year, :numericality => {:greater_than => 1900, :less_than => 2010, :allow_blank => true}
  validates :heard_about_ruby_year, :numericality => {:greater_than => 1900, :less_than => 2010, :allow_blank => true}
  validates :started_ruby_year, :numericality => {:greater_than => 1900, :less_than => 2010, :allow_blank => true}
  
  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, :allow_blank => true

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

  def authorised?
    !provider.blank? || !twitter_account.blank?
  end

protected
  def clear_cities_cache
    Rails.cache.delete(:cities_for_map) if city_id_changed?
  end
end
