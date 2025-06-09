class Achievement < ApplicationRecord
  has_many :user_achievements, dependent: :destroy
  has_many :users, through: :user_achievements

  validates :name, :description, :icon, :category, :key, presence: true
  validates :key, uniqueness: true
  validates :tier, inclusion: { in: 1..4 }

  CATEGORIES = {
    communication: "Коммуникация",
    social: "Социальные",
    activity: "Активность",
    special: "Особые",
    level: "Уровни"
  }.freeze

  TIERS = {
    1 => { name: "Бронза", color: "#CD7F32" },
    2 => { name: "Серебро", color: "#C0C0C0" },
    3 => { name: "Золото", color: "#FFD700" },
    4 => { name: "Платина", color: "#E5E4E2" }
  }.freeze

  scope :by_category, ->(category) { where(category: category) }
  scope :by_tier, ->(tier) { where(tier: tier) }

  def percentage_of_users
    return 0 if User.count.zero?
    (users.count.to_f / User.count * 100).round(1)
  end

  def tier_name
    TIERS[tier][:name]
  end

  def tier_color
    TIERS[tier][:color]
  end

  def category_name
    CATEGORIES[category.to_sym]
  end
end
