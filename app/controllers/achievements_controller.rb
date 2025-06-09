class AchievementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = params[:user_id] ? User.find(params[:user_id]) : current_user
    @selected_category = params[:category] || 'all'

    achievements = if @selected_category == 'all'
      Achievement.all
    else
      Achievement.by_category(@selected_category)
    end

    @achievements_by_category = achievements.group_by(&:category)
    @user_achievement_ids = @user.achievement_ids
    @total_points = @user.achievements.sum(:points)

    # Statistics for each category
    @category_stats = {}
    Achievement::CATEGORIES.keys.each do |cat|
      category_achievements = Achievement.by_category(cat)
      earned = category_achievements.joins(:user_achievements).where(user_achievements: { user_id: @user.id }).count
      total = category_achievements.count
      @category_stats[cat] = { earned: earned, total: total }
    end
  end
end
