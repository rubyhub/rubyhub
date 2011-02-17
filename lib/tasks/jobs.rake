namespace :jobs do
  task :jooble => :environment do
    begin
      require 'nokogiri'
      
      xml = Haml::Engine.new(File.read('app/views/jooble_request.haml'), :attr_wrapper => '"').to_html

      url = URI.parse('http://jooble.com.ua/Export/XmlSearchResult.ashx/')
      request = Net::HTTP::Post.new(url.path, {'Content-Type' => 'text/xml'})
      request.body = xml
      response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
      
      doc = Nokogiri::XML(response.body)
      doc.css('messages>msg').each do |message|
        JobOffer.from_jooble(message)
      end
    rescue Timeout::Error
      # do nothing, it happens sometimes
    end
  end
end
