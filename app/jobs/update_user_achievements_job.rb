class UpdateUserAchievementsJob
  include Sidekiq::Job
  
  sidekiq_options queue: :default,
                  retry: 3,
                  lock: :until_executed,
                  lock_args_method: :lock_args,
                  lock_ttl: 5.minutes,
                  on_conflict: {
                    client: :log,
                    server: :reschedule
                  }

  def self.lock_args(args)
    # Only lock based on user_id
    [args[0]]
  end

  def perform(user_id, achievement_type = nil)
    user = User.find(user_id)
    
    # Check and grant achievements based on user activity
    if achievement_type
      check_specific_achievement(user, achievement_type)
    else
      check_all_achievements(user)
    end
    
    Rails.logger.info "Updated achievements for user #{user_id}"
  rescue ActiveRecord::RecordNotFound
    Rails.logger.error "User #{user_id} not found"
  end
  
  private
  
  def check_specific_achievement(user, type)
    case type
    when 'first_message'
      grant_achievement(user, 'first_message') if user.sent_messages.count >= 1
    when 'active_chatter'
      grant_achievement(user, 'active_chatter') if user.sent_messages.count >= 100
    when 'conversation_starter'
      grant_achievement(user, 'conversation_starter') if user.conversations.count >= 10
    end
  end
  
  def check_all_achievements(user)
    check_specific_achievement(user, 'first_message')
    check_specific_achievement(user, 'active_chatter')
    check_specific_achievement(user, 'conversation_starter')
  end
  
  def grant_achievement(user, achievement_name)
    achievement = Achievement.find_by(name: achievement_name)
    return unless achievement
    
    UserAchievement.find_or_create_by(user: user, achievement: achievement) do |ua|
      ua.earned_at = Time.current
      Rails.logger.info "Granted '#{achievement_name}' achievement to user #{user.id}"
    end
  end
end