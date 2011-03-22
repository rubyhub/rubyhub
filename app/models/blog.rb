require 'http_helper'

class Blog < ActiveRecord::Base
  enum_attr :status, %w(^pending active invalid)

  belongs_to :user
  has_many :blog_posts

  validates_presence_of :rss
  validates_format_of :rss, :with => /^(http|https):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  validates_uniqueness_of :rss

  named_scope :active, where(:status => :active)

  attr_protected :status, :title

  def favicon_url
    host = URI.parse(url).host rescue nil
    "http://www.google.com/s2/favicons?domain=#{host}"
  end

  def update!
    response = HttpHelper.follow_redirects(self.rss, :return => :response)

    if !response || (response.code != '200')
      self.status = :invalid
      self.save!
    else
      rss = Nokogiri::XML.parse(response.body, nil, 'UTF-8')

      self.title = rss.css('channel > title').text.strip
      self.url = rss.css('channel > link').text.strip
      self.save!

      # create missing posts
      rss.css('channel item').each do |item|
        BlogPost.from_rss_item(self, item)
      end
    end
  end
end
