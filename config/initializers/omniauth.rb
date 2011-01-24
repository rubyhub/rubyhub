require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  twitter_config = YAML.load_file('config/twitter.yml')

  provider :open_id, OpenID::Store::Filesystem.new(File.join(Rails.root,'tmp'))
  provider :open_id, OpenID::Store::Filesystem.new(File.join(Rails.root,'tmp')), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :twitter, twitter_config['auth_consumer_key'], twitter_config['auth_consumer_secret']
end
