require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  keys = YAML.load_file('config/keys.yml')

  provider :open_id, OpenID::Store::Filesystem.new(File.join(Rails.root,'tmp'))
  provider :open_id, OpenID::Store::Filesystem.new(File.join(Rails.root,'tmp')), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  %w(twitter github linked_in).each do |provider_name|
    provider provider_name, keys[provider_name]['auth_consumer_key'], keys[provider_name]['auth_consumer_secret']
  end
end
