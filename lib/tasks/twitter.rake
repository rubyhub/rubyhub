namespace :twitter do
  task :collect_tweets => :environment do
    require 'twitter_client'

    begin
      client = TwitterClient.new
      client.sync_friends_with_accounts
      client.get_tweets
    rescue Twitter::BadGateway, Twitter::ServiceUnavailable
      # do nothing, it's a regular Twitter issue.
    end
  end

  task :check_if_interesting => :environment do
    Tweet.find_each do |tweet|
      tweet.send(:check_if_interesting)
      tweet.save!
    end
  end
end
