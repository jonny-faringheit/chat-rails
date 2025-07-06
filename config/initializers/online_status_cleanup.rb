Rails.application.config.after_initialize do
  if defined?(Rails::Server)
    Thread.new do
      loop do
        sleep 60 # Run every minute
        MarkInactiveUsersOfflineJob.perform_later
      rescue => e
        Rails.logger.error "Error in online status cleanup: #{e.message}"
      end
    end
  end
end
