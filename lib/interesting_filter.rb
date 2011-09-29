class InterestingFilter
  def initialize(words=nil)
    @filter_words = words || default_filter_words 
  end

  def interesting?(text)
    test_text = text.mb_chars.downcase
    return !!@filter_words.find_index{|word| test_text =~ /\b#{word}\b/}
  end

protected
  def default_filter_words
    File.read(File.join(Rails.root, 'config', 'filter_words.txt')).split("\n").map(&:strip).reject(&:empty?)
  end
end
