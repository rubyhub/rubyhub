class JobOffer < ActiveRecord::Base
  has_and_belongs_to_many :cities

  validates_presence_of :title
  validates_presence_of :urls
  validates :joobleid, :presence => true, :uniqueness => true
      
  named_scope :interesting, where(:interesting => true)
  named_scope :mainpage, interesting.order('published_on DESC').limit(20)
  
  before_create :check_if_interesting

  def self.filter_words
    %w(ruby rails)
  end

  def self.from_jooble(message)
    attrs = {
      :joobleid => message['id'].strip,
      :title => message.css('position').text.strip,
      :salary => message.css('salary').text.strip,
      :text => message.css('desc').text.strip,
      :published_on => message.css('updated').text.strip.to_i.days.ago.to_date,
      :urls => message.css('sources > source > url').map(&:text).map(&:strip).join("\n")
    }
    cities = message.css('region').text.split(',').map{|r| City.find_by_title(r.strip)}.compact
    job_offer = JobOffer.find_by_joobleid(attrs[:joobleid]) || JobOffer.new

    job_offer.update_attributes!(attrs)
    job_offer.cities = cities

    job_offer
  end

  def url
    urls.split("\n").sample
  end

protected

  def check_if_interesting
    self.interesting = JobOffer.filter_words.find_index{|word| title.mb_chars.downcase.include? word}!=nil
    return true
  end
end
