class MainController < ApplicationController
  def index
    @tweets = Tweet.limit(20)
    @blog_posts = BlogPost.limit(20)
  end
end
