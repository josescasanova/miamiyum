RSqoot.configure do |config|
  config.public_api_key        = ENV['SQOOT_PUBLIC_KEY']
  config.private_api_key       = ENV['SQOOT_PRIVATE_KEY']
  config.base_api_url          = 'http://api.sqoot.com/v2/'
  config.authentication_method = :header
  config.read_timeout          = 60.seconds
  config.expired_in            = 1.second
end
