class City < ActiveRecord::Base
  belongs_to :region
  has_many :users

  validates :title, :presence => true
  validates_uniqueness_of :title, :scope => :region_id

  default_scope order('title ASC')

  def self.for_map
    cities = City.all
    max_lon = cities.map(&:real_lon).max
    min_lon = cities.map(&:real_lon).min
    max_lat = cities.map(&:real_lat).max
    min_lat = cities.map(&:real_lat).min
    max_size = cities.map(&:users_count).max
    width = max_lon-min_lon
    height = max_lat-min_lat
    scale = 600/[width,height].max

    {
      :width => (width*scale).to_i,
      :height => (height*scale).to_i,
      :cities => cities.map {|city|
        {
          :x => ((city.real_lon-min_lon)*scale).to_i,
          :y => ((height+min_lat-city.real_lat)*scale).to_i,
          :size => max_size==0 ? 0 : (20.0*city.users_count/max_size).to_i,
          :title => city.title
        }
      }.sort{|a,b| a[:size]<=>b[:size]}
    }
  end

  def real_lon
    lon*79
  end

  def real_lat
    lat*111
  end
end
