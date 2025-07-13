class CleanupOldMessagesJob
  include Sidekiq::Job
  
  sidekiq_options queue: :low,
                  retry: 2,
                  lock: :while_executing,
                  lock_timeout: 10.minutes,
                  lock_ttl: 1.hour,
                  lock_limit: 1,
                  on_conflict: {
                    client: :reject,
                    server: :reschedule
                  }

  def perform(days_to_keep = 90)
    cutoff_date = days_to_keep.days.ago
    
    # Delete messages older than cutoff date in batches
    deleted_count = 0
    
    Message.where("created_at < ?", cutoff_date)
           .in_batches(of: 1000) do |batch|
      deleted_count += batch.delete_all
      
      # Small pause to prevent database overload
      sleep 0.1
    end
    
    Rails.logger.info "Cleaned up #{deleted_count} messages older than #{days_to_keep} days"
    
    # Update conversation message counts
    update_conversation_counts
  end
  
  private
  
  def update_conversation_counts
    Conversation.find_each do |conversation|
      conversation.update_column(:messages_count, conversation.messages.count)
    end
  end
end