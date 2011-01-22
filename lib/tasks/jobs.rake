namespace :jobs do
  task :jooble => :environment do
    request = Haml::Engine.new(File.read('app/views/jooble_request.haml'), :attr_wrapper => '"').to_html

    url = URI.parse('http://jooble.com.ua/Export/XmlSearchResult.ashx/')
    request = Net::HTTP::Post.new(url.path, {'Content-Type' => 'text/xml'})
    request.body = request
    response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
    puts response.code
    puts response.body
  end
end
