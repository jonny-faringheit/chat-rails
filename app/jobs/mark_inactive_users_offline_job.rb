class MarkInactiveUsersOfflineJob
  include Sidekiq::Job

  sidekiq_options queue: :low,
                  retry: 5,
                  lock: :until_and_while_executing,
                  lock_timeout: nil,
                  lock_ttl: 90.seconds,
                  lock_limit: 1,
                  on_conflict: {
                    client: :log,
                    server: :raise
                  }

  def perform
    # Mark users as offline if they haven't been seen for more than 5 minutes
    # Use in_batches to avoid locking too many rows at once
    marked_count = 0

    User.where(online: true)
        .where("last_seen_at < ?", 5.minutes.ago)
        .in_batches(of: 100) do |batch|
          marked_count += batch.update_all(online: false)
        end

    Rails.logger.info "Marked #{marked_count} users as offline"
  end
end
