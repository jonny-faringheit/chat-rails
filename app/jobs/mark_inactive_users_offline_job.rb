class MarkInactiveUsersOfflineJob < ApplicationJob
  queue_as :default

  def perform
    # Mark users as offline if they haven't been seen for more than 5 minutes
    User.where(online: true)
        .where("last_seen_at < ?", 5.minutes.ago)
        .update_all(online: false)
  end
end
