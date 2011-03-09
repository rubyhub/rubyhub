namespace :blogs do
  task :update => :environment do
    require 'nokogiri'
    require 'net/http'

    Blog.active.each do |blog|
      blog.update!
    end
  end

  task :actualize => :environment do
    BlogPost.find_each do |post|
      post.url = BlogPost.remove_utm_params(HttpHelper.expand_url(post.url))
      if post.url_changed? && BlogPost.exists?(:url => post.url)
        post.destroy
      else
        post.send(:check_if_interesting)
        post.save!
      end
    end
  end
end
