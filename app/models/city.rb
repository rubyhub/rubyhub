class City < ActiveRecord::Base
  belongs_to :region

  validates :title, :presence => true
  validates_uniqueness_of :title, :scope => :region_id

  default_scope order('title ASC')
end
