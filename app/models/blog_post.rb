require 'http_helper'
require 'uri'
require 'cgi'

class BlogPost < ActiveRecord::Base
  belongs_to :blog

  validates_presence_of :title
  validates_presence_of :url
  validates_presence_of :blog_id
  validates_uniqueness_of :url, :scope => :blog_id
  
  scope :interesting, where(:interesting => true)
  scope :mainpage, interesting.order('published_at DESC').includes(:blog).limit(20)
  
  before_create :check_if_interesting

  def self.from_rss_item(blog, item)
    url = remove_utm_params(HttpHelper.expand_url(item.css('link').text.strip))

    unless blog.blog_posts.exists?(:url => url)
      d=Nokogiri::HTML::Document.parse('', nil,'UTF-8')
      text = CGI::unescapeHTML(Nokogiri::HTML::DocumentFragment.new(d, item.css('description').text).text).mb_chars.downcase.strip
      categories = item.css('category').map(&:text).join(' ').mb_chars.downcase
      attrs = {
        :url => url,
        :published_at => Time.zone.parse(item.css('pubDate').text.strip),
        :title => item.css('title').text.strip,
        :text =>  text + ' ' + categories
      }
      blog.blog_posts.create!(attrs)
    end
  end

  def self.remove_utm_params(url)
    uri = URI.parse(url)

    if uri.query
      query = CGI.parse(uri.query)
      query.delete('utm_source')
      query.delete('utm_medium')
      query.delete('utm_campaign')
      uri.query = query.empty? ? nil : query.map do |name,values|
        values.compact.map do |value|
          if name.nil?
            CGI.escape(value)
          else
            "#{CGI.escape name}=#{CGI.escape value}"
          end
        end
      end.flatten.join("&")
    end

    uri.to_s
  end

protected
  def check_if_interesting
    @@interesting_filter ||= InterestingFilter.new
    self.interesting = @@interesting_filter.interesting?(self.text)
    return true
  end
end
