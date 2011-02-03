class Tweet < ActiveRecord::Base
  belongs_to :account, :class_name => 'TwitterAccount'

  named_scope :interesting, where(:interesting => true)
  named_scope :mainpage, interesting.order('published_at DESC').includes(:account).limit(20)

  before_create :check_if_interesting
  before_create :parse_text

  def self.filter_words
    @filter_words || File.read(File.join(Rails.root, 'config', 'filter_words.txt')).split("\n").map(&:strip).reject(&:empty?)
  end

  def url
    account.url + "/statuses/" + twitterid
  end

  def html
    self[:html].html_safe
  end

protected
  def check_if_interesting
    test_text = text.mb_chars.downcase
    self.interesting = Tweet.filter_words.find_index{|word| test_text.include? word}!=nil
    return true
  end

  def follow_redirects(url, depth=0)
    return url if depth==5
    uri = URI.parse(url)
    response = nil
    Net::HTTP.start(uri.host, uri.port) do |http|
      response = http.head(uri.path)
    end
    if response.code.to_s[0,1]=='3' # redirect
      return follow_redirects(response['location'], depth+1)
    else
      return url
    end
  end

  def parse_text
    escaped_text = CGI.escapeHTML(text.gsub('&lt;','<').gsub('&gt;','>'))
    if self.interesting?
      self.html = escaped_text.gsub(ActionView::Helpers::TextHelper::AUTO_LINK_RE) do
        url = $&
        final_url = follow_redirects(url)
        begin
          host = URI.parse(final_url).host
        rescue
          host = '???'
        end
        "<a href=\"#{CGI.escapeHTML(final_url)}\" target=\"_blank\">#{CGI.escapeHTML(host)}»</a>"
      end
      return true
    else
      self.html=CGI.escapeHTML(self.text)
    end
  end
end
