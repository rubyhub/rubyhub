class MainController < ApplicationController
  def index
    @tweets = Tweet.mainpage
    @blog_posts = BlogPost.mainpage
    @job_offers = JobOffer.mainpage
  end
end
