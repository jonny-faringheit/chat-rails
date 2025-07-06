class Conversation < ApplicationRecord
  has_many :conversation_participants, dependent: :destroy
  has_many :participants, through: :conversation_participants, source: :user
  has_many :messages, dependent: :destroy

  validates :participants, length: { minimum: 2, message: "must have at least 2 participants" }
  validate :unique_conversation_between_users, on: :create

  scope :between_users, ->(current_user, interlocutor) {
    joins(:participants)
      .where(participants: { id: [current_user.id, interlocutor.id] })
      .group('conversations.id')
      .having('COUNT(conversation_participants.id) = 2')
  }
  scope :for_user, ->(user) {
    includes(:participants).joins(:participants).where(participants: { id: user.id })
  }

  def ordered_messages
    messages.includes(:sender).order(created_at: :asc)
  end

  def last_message
    @last_message ||= messages.order(created_at: :desc).first
  end

  def unread_count(user)
    messages.unread.where.not(sender: user).count
  end

  def interlocutor_for(user)
    participants.where.not(id: user.id).first
  end

  private

  def unique_conversation_between_users
    return unless participants.size == 2

    existing = Conversation.between_users(participants.first, participants.last).exists?
    errors.add(:base, "Conversation already exists between these users") if existing
  end
end
