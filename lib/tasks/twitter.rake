namespace :twitter do
  task :collect_tweets => :environment do
    require 'twitter_client'

    client = TwitterClient.new
    client.sync_friends_with_accounts
    client.get_tweets
  end
end
