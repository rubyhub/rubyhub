require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  keys = YAML.load_file('config/keys.yml')
  twitter_config = keys['twitter']
  github_config = keys['github']

  provider :open_id, OpenID::Store::Filesystem.new(File.join(Rails.root,'tmp'))
  provider :open_id, OpenID::Store::Filesystem.new(File.join(Rails.root,'tmp')), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :twitter, twitter_config['auth_consumer_key'], twitter_config['auth_consumer_secret']
  provider :github, github_config['auth_consumer_key'], github_config['auth_consumer_secret']
end
