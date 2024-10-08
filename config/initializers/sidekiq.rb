# frozen_string_literal: true

require 'sidekiq/web'

sidekiq_config = { ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
sidekiq_config[:url] = ENV['REDIS_URL'] if ENV['REDIS_URL'].present?

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end
Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end

Sidekiq.strict_args!(false)

Sidekiq::Web.app_url = '/sidekiq'
