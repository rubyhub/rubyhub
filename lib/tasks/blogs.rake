namespace :blogs do
  task :update => :environment do
    require 'nokogiri'
    require 'net/http'

    Blog.active.each do |blog|
      url = URI.parse(blog.rss)
      found = false
      until found
        host, port = url.host, url.port if url.host && url.port
        req = Net::HTTP::Get.new(url.path||'')
        res = Net::HTTP.start(host, port) {|http|  http.request(req) }
        res.header['location'] ? url = URI.parse(res.header['location']) : found = true
      end
      if res.code != '200'
        blog.status = :invalid
        blog.save!
      end
      rss = Nokogiri::XML.parse(res.body,nil, 'UTF-8')

      blog.title = rss.css('channel > title').text.strip
      blog.url = rss.css('channel > link').text.strip
      blog.save!

      # create missing posts
      rss.css('channel item').each do |item|
        BlogPost.from_rss_item(blog, item)
      end
    end
  end
end
