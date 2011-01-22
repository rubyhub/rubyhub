class MainController < ApplicationController
  def index
    @tweets = Tweet.mainpage
    @blog_posts = BlogPost.mainpage
  end
end
