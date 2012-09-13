if Rails.env.test? or Rails.env.Development?
  CarrierWave.configure do |config|
    config.storage = :file
    config.base_path = "http://status.1trip.me"
  end
end

if Rails.env.Production?
  CarrierWave.configure do |config|
    config.storage = :file
    config.base_path = "http://status.1trip.me"
  end
end