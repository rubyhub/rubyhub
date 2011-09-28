class TwitterAccount < ActiveRecord::Base
  belongs_to :user
  has_many :tweets, :foreign_key => :account_id

  enum_attr :status, %w(^pending active disabled invalid)

  validates_presence_of :name
  validates_format_of :name, :with => /^[A-Za-z0-9_]+$/
  validates_uniqueness_of :name

  scope :active, where(:status => :active)

  attr_protected :twitterid, :avatar_url, :status, :user_id

  def url
    "http://twitter.com/#{name}"
  end
end
