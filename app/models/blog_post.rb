class BlogPost < ActiveRecord::Base
  belongs_to :blog

  validates_presence_of :title
  validates_presence_of :url
  validates_presence_of :blog_id
  validates_uniqueness_of :url, :scope => :blog_id
end
