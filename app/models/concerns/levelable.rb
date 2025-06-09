module Levelable
  extend ActiveSupport::Concern

  # Level and XP methods
  def xp_for_next_level
    return 0 if level >= 100 # Max level
    (level + 1) ** 2 * 100
  end

  def xp_for_current_level
    level ** 2 * 100
  end

  def xp_progress
    current_xp - xp_for_current_level
  end

  def xp_needed_for_next_level
    xp_for_next_level - xp_for_current_level
  end

  def level_progress_percentage
    return 100 if level >= 100
    (xp_progress.to_f / xp_needed_for_next_level * 100).round
  end

  def add_xp(amount)
    self.current_xp += amount
    check_level_up
    save
  end

  private

  def check_level_up
    while current_xp >= xp_for_next_level && level < 100
      self.level += 1
      check_level_achievements if respond_to?(:check_level_achievements, true)
    end
  end
end
