class User < ApplicationRecord
  include LoginGenerator
  include DateOfBirthGenerator
  include Achievable
  include Levelable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :conversation_participants, dependent: :destroy
  has_many :conversations, through: :conversation_participants
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
  validate :avatar_validation, if: -> { avatar.attached? }

  def full_name_present?
    first_name.present? && last_name.present?
  end

  def full_name
    if first_name.present? && last_name.present?
      "#{first_name} #{last_name}"
    else
      'not specified'
    end
  end

  def age_present?
    date_of_birth.present? ? self.age : false
  end

  def age
    if date_of_birth.present?
      now = Time.zone.now
      age = now.year - date_of_birth.year
      age -= 1 if (now.month < date_of_birth.month) || (now.month == date_of_birth.month && now.day < date_of_birth.day)
      age
    else
      'not specified'
    end
  end

  def to_param
    login
  end

  private

  def avatar_validation
    return unless avatar.attached?

    unless avatar.content_type.in?(%w[image/jpeg image/jpg image/png image/gif])
      errors.add(:avatar, "должно быть в формате JPEG, PNG или GIF")
    end

    if avatar.byte_size > 5.megabytes
      errors.add(:avatar, "должно быть меньше 5MB")
    end
  end
end
