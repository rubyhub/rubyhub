class BlogPost < ActiveRecord::Base
  belongs_to :blog

  validates_presence_of :title
  validates_presence_of :url
  validates_presence_of :blog_id
  validates_uniqueness_of :url, :scope => :blog_id
  
  named_scope :interesting, where(:interesting => true)
  named_scope :mainpage, interesting.order('published_at DESC').includes(:blog).limit(20)
  
  before_create :check_if_interesting

protected
  def check_if_interesting
    require 'nokogiri'
    d=Nokogiri::HTML::Document.parse('',nil,'UTF-8')
    test_text = self.title+' '+CGI::unescapeHTML(Nokogiri::HTML::DocumentFragment.new(d, self.text).text).mb_chars.downcase
    self.interesting = Tweet.filter_words.find_index{|word| test_text.include? word}!=nil
    return true
  end
end
