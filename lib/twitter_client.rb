require 'twitter'
require 'yaml'

class TwitterClient
  def initialize
    credentials = YAML::load_file("#{Rails.root}/config/keys.yml")['twitter'].symbolize_keys!
    Twitter.configure do |config|
      config.consumer_key = credentials[:consumer_key]
      config.consumer_secret = credentials[:consumer_secret]
      config.oauth_token = credentials[:oauth_token]
      config.oauth_token_secret = credentials[:oauth_token_secret]
    end
  end

  def follow_account(twitter_account)
    begin
      user_info = Twitter.user(twitter_account.name)
      twitter_account.uid = user_info.id
      twitter_account.avatar_url = user_info.profile_image_url
      Twitter.friendship_create(user_info.id)
    rescue Twitter::NotFound
      raise 'Username is invalid'
    rescue Twitter::Forbidden => e
      if e.to_s =~ /is already on your list/
        # uhm, do nothing. User is already on the list
      else
        twitter_account.status = :invalid
      end
    end
  end

  def sync_friends_with_accounts
    friend_ids = Twitter.friend_ids[:ids].map(&:to_s)
    active_accounts = TwitterAccount.active

    # follow accounts that aren't on our friends list
    active_accounts.each do |account| 
      if account.uid.blank? || !friend_ids.include?(account.uid)
        follow_account(account)
        account.save! 
      end
    end

    # unfollow accounts that aren't in our active accounts
    (friend_ids - active_accounts.map(&:uid)).each do |userid| 
      Twitter.friendship_destroy(userid) 
    end
  end

  def get_tweets
#    if since_id = Tweet.find(:first, :order => 'created_at DESC').try(:twitterid)
#      tweets = Twitter.friends_timeline(:count => 200, :since_id => since_id)
#    else
      tweets = Twitter.friends_timeline(:count => 200)
#    end
    
    tweets.each do |tweet|
      next if Tweet.exists?(:twitterid => tweet[:id])
      account = TwitterAccount.find_by_name(tweet["user"]["screen_name"])
      next if account.nil?
      tweet = account.tweets.create!(:published_at => Time.parse(tweet["created_at"]), :text => tweet["text"], :twitterid => tweet["id"])
      if tweet.interesting?
        Twitter.retweet(tweet.twitterid)
      end
    end
  end

end
