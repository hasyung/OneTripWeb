CanTango.config do |config|
  config.engines.all :on
  config.debug.set :on
  config.engine(:permission).set :off
  config.engine(:cache).set :off
end
