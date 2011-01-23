class Tweet < ActiveRecord::Base
  belongs_to :account, :class_name => 'TwitterAccount'

  named_scope :interesting, where(:interesting => true)
  named_scope :mainpage, interesting.order('published_at DESC').includes(:account).limit(20)

  before_create :check_if_interesting
  

  def self.filter_words
    @filter_words || File.read(File.join(Rails.root, 'config', 'filter_words.txt')).split("\n").map(&:strip).reject(&:empty?)
  end


protected
  def check_if_interesting
    test_text = text.mb_chars.downcase
    self.interesting = Tweet.filter_words.find_index{|word| test_text.include? word}!=nil
  end
end
