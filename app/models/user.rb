class User < ApplicationRecord
  include PgSearchWithTrigram
  include LoginGenerator
  include DateOfBirthGenerator
  include Achievable
  include Levelable

  # PgSearch configuration
  enable_pg_trigram_search(against: [:first_name, :last_name, :login])

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :conversation_participants, dependent: :destroy
  has_many :conversations, -> { extending Extensions::FindAllConversationsWithUserExtension },
                           through: :conversation_participants
  has_many :sent_messages, class_name: "Message", foreign_key: :sender_id, dependent: :destroy

  has_one_attached :avatar

  validates :email, presence: true, uniqueness: { case_sensitive: false }, 'valid_email_2/email': true
  validates :login, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 35 }, format: { with: /\A[a-zA-Z0-9._-]+\z/ }
  validates :first_name, length: { in: 2..35 }, format: { with: /\A[\p{L}\s\-']+\z/ }, on: :update
  validates :last_name, length: { in: 2..35 }, format: { with: /\A[\p{L}\s\-']+\z/ }, on: :update
  validates :level, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }
  validates :current_xp, numericality: { greater_than_or_equal_to: 0 }
  validates :date_of_birth, date_check: true, on: :update
  validates :country, length: { maximum: 50 }, allow_blank: true
  validates :city, length: { maximum: 50 }, allow_blank: true
  validates :avatar, avatar: true, if: -> { avatar.attached? }

  before_create :set_initial_last_seen_at
  after_update :clear_memoized_values, if: :saved_change_to_first_name_or_last_name?

  def full_name_present?
    first_name.present? && last_name.present?
  end

  def full_name
    @full_name ||= Users::NameFormatter.new(self).call
  end

  def age_present?
    date_of_birth.present?
  end

  def age
    @age ||= Users::AgeCalculator.new(self.date_of_birth).call
  end

  def to_param
    login
  end

  def mark_as_online!
    update_columns(online: true, last_seen_at: Time.current)
  end

  def mark_as_offline!
    update_columns(online: false, last_seen_at: Time.current)
  end

  def online_status
    online? ? 'online' : 'offline'
  end

  private

  def set_initial_last_seen_at
    self.last_seen_at ||= Time.current
  end

  def clear_memoized_values
    @full_name = nil
    @age = nil if saved_change_to_date_of_birth?
  end

  def saved_change_to_first_name_or_last_name?
    saved_change_to_first_name? || saved_change_to_last_name?
  end
end
