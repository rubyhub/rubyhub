require 'http_helper'

class Tweet < ActiveRecord::Base

  # http://daringfireball.net/2010/07/improved_regex_for_matching_urls
  URL_RE = /(?i)\b((?:https?:(?:\/{1,3}|[a-z0-9%])|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))/

  belongs_to :account, :class_name => 'TwitterAccount'

  scope :interesting, where(:interesting => true)
  scope :mainpage, interesting.order('published_at DESC').includes(:account).limit(20)

  before_create :check_if_interesting
  before_create :parse_text

  def url
    account.url + "/statuses/" + twitterid
  end

  def html
    self[:html].html_safe
  end

protected
  def check_if_interesting
    @@interesting_filter ||= InterestingFilter.new
    self.interesting = @@interesting_filter.interesting?(self.text)
    return true
  end

  def parse_text
    if self.interesting?
      escaped_text = CGI.escapeHTML(text.gsub('&lt;','<').gsub('&gt;','>'))
      self.html = escaped_text.gsub(Tweet::URL_RE) do
        url = $&
        final_url = HttpHelper.expand_url(url)
        host = URI.parse(final_url).host rescue nil
        host ||= final_url # case in question: balans:zagal'nyi recognized as an URL 
        "<a href=\"#{CGI.escapeHTML(final_url)}\" target=\"_blank\">#{CGI.escapeHTML(host)}»</a>"
      end
    else
      self.html=CGI.escapeHTML(self.text)
    end
    return true
  end
end
