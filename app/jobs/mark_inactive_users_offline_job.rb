class MarkInactiveUsersOfflineJob < ApplicationJob
  queue_as :default

  def perform
    # Mark users as offline if they haven't been seen for more than 5 minutes
    # Use in_batches to avoid locking too many rows at once
    User.where(online: true)
        .where("last_seen_at < ?", 5.minutes.ago)
        .in_batches(of: 1000)
        .update_all(online: false)
  end
end
