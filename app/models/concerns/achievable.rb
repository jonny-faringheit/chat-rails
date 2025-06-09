module Achievable
  extend ActiveSupport::Concern

  included do
    has_many :user_achievements, dependent: :destroy
    has_many :achievements, through: :user_achievements
  end

  def grant_achievement(achievement_key)
    achievement = Achievement.find_by(key: achievement_key)
    return false unless achievement
    return true if has_achievement?(achievement_key)
    user_achievements.create!(achievement: achievement)
    add_xp(achievement.points)
    true
  end

  def has_achievement?(achievement_key)
    achievements.exists?(key: achievement_key)
  end

  def achievement_points
    achievements.sum(:points)
  end

  def achievements_by_category(category)
    achievements.where(category: category)
  end

  def achievement_progress
    total = Achievement.count
    earned = achievements.count
    return 0 if total.zero?
    (earned.to_f / total * 100).round
  end

  def check_level_achievements
    case level
    when 10
      grant_achievement('level_10')
    when 25
      grant_achievement('level_25')
    when 50
      grant_achievement('level_50')
    when 100
      grant_achievement('level_100')
    end
  end

  def check_message_achievements
    message_count = sent_messages.count
    case message_count
    when 1
      grant_achievement('first_message')
    when 100
      grant_achievement('talkative')
    when 1000
      grant_achievement('speaker')
    when 10000
      grant_achievement('chat_legend')
    end
  end

  def check_social_achievements
    conversation_count = conversations.count
    case conversation_count
    when 1
      grant_achievement('first_contact')
    when 10
      grant_achievement('friendly')
    when 50
      grant_achievement('popular')
    when 100
      grant_achievement('social_butterfly')
    end
  end

  def check_profile_achievements
    if first_name.present? && last_name.present? && date_of_birth.present? && login.present?
      grant_achievement('perfectionist')
    end
  end

  def check_time_based_achievements(time = Time.current)
    hour = time.hour
    # Night owl - after midnight and before 5 AM
    if hour >= 0 && hour < 5
      grant_achievement('night_owl')
    end
    # Early bird - between 5 AM and 6 AM
    if hour >= 5 && hour < 6
      grant_achievement('early_bird')
    end
    # Birthday - one year on platform
    if created_at <= 1.year.ago && !has_achievement?('birthday')
      grant_achievement('birthday')
    end
  end
end
