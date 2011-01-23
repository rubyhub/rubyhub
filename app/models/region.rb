class Region < ActiveRecord::Base
  has_many :cities

  validates :title, :presence => true, :uniqueness => true
end
