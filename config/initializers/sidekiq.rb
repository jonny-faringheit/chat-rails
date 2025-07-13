# Sidekiq server configuration
Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }

  # Configure error handling
  config.error_handlers << Proc.new do |ex, ctx_hash|
    Rails.logger.error "Sidekiq error: #{ex.class} - #{ex.message}"
    Rails.logger.error ex.backtrace.join("\n") if ex.backtrace
  end

  # Configure server middleware
  config.server_middleware do |chain|
    # Add any server middleware here
    chain.add SidekiqUniqueJobs::Middleware::Server
  end

  config.client_middleware do |chain|
    # Add any client middleware here
    chain.add SidekiqUniqueJobs::Middleware::Client
  end

  SidekiqUniqueJobs::Server.configure(config)
end

# Sidekiq client configuration
Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }

  # Configure client middleware
  config.client_middleware do |chain|
    # Add any client middleware here
    chain.add SidekiqUniqueJobs::Middleware::Client
  end
end

# Configure queues and their priorities
# Sidekiq will check queues in this order
Sidekiq.default_job_options = {
  'retry' => 3,
  'backtrace' => true
}
