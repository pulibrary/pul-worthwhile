require 'active_fedora/noid'

ActiveFedora::Noid.configure do |config|
  config.statefile = 'noid-minter-state'
  config.template = 'd.zdeeek'
  #config.seed = '153572761077996293261137207563891833346'
end