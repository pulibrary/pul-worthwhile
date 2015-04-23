# Config for EZID ARK minter
Ezid::Client.configure do |config|
  config.user = PulWorthwhile418::Application::PUL_DAM_CONFIG['ezid_user']
  config.password = PulWorthwhile418::Application::PUL_DAM_CONFIG['ezid_password']
  config.default_shoulder = PulWorthwhile418::Application::PUL_DAM_CONFIG['ezid_default_shoulder']
end