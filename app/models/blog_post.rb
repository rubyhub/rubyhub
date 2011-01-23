class BlogPost < ActiveRecord::Base
  belongs_to :blog

  validates_presence_of :title
  validates_presence_of :url
  validates_presence_of :blog_id
  validates_uniqueness_of :url, :scope => :blog_id
  
  named_scope :interesting, where(:interesting => true)
  named_scope :mainpage, interesting.order('published_at DESC').includes(:blog).limit(20)
  
  before_create :check_if_interesting

  def self.from_rss_item(blog, item)
    url = item.css('link').text.strip
    unless blog.blog_posts.exists?(:url => url)
      d=Nokogiri::HTML::Document.parse('',nil,'UTF-8')
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

protected
  def check_if_interesting
    self.interesting = Tweet.filter_words.find_index{|word| (title+' '+text).include? word}!=nil
    return true
  end
end
