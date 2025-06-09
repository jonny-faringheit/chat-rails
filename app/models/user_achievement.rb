class UserAchievement < ApplicationRecord
  belongs_to :user
  belongs_to :achievement

  validates :earned_at, presence: true
  validates :achievement_id, uniqueness: { scope: :user_id }

  scope :recent, -> { order(earned_at: :desc) }

  before_validation :set_earned_at, on: :create

  private

  def set_earned_at
    self.earned_at ||= Time.current
  end
end
