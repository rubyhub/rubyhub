require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :open_id, OpenID::Store::Filesystem.new(File.join(Rails.root,'tmp'))
end
