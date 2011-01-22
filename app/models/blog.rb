class Blog < ActiveRecord::Base
  enum_attr :status, %w(^pending active invalid)

  has_many :blog_posts

  validates_presence_of :rss
  validates_format_of :rss, :with => /^(http|https):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  validates_uniqueness_of :rss

  named_scope :active, where(:status => :active)

  attr_protected :status, :title
end
