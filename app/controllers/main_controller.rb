class MainController < ApplicationController
  def index
    @tweets = Tweet.limit(20)
  end
end
