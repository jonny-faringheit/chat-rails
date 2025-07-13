class Conversation < ApplicationRecord
  has_many :conversation_participants, dependent: :destroy
  has_many :participants, through: :conversation_participants, source: :user
  has_many :messages, dependent: :destroy
  has_one :last_message_association, -> { order(created_at: :desc) }, class_name: 'Message'

  validates :participants, length: { minimum: 2, message: "must have at least 2 participants" }
  validate :unique_conversation_between_users, on: :create

  scope :for_user, ->(user) {
    joins(:participants).where(participants: { id: user.id })
  }

  def self.between_users(array_users)
    user_1, user_2 = array_users
    joins(:conversation_participants)
      .where(conversation_participants: { user_id: [user_1.id, user_2.id] })
      .group('conversations.id')
      .having('COUNT(DISTINCT conversation_participants.user_id) = 2
               AND COUNT(conversation_participants.id) = 2')
      .first
  end

  def self.find_with_participants(conversation_id)
    includes(:participants).find(conversation_id)
  end

  def ordered_messages
    messages.includes(:sender).order(created_at: :asc)
  end

  def last_message
    last_message_association || messages.order(created_at: :desc).first
  end

  def unread_count(user)
    participant = conversation_participants.find_by(user: user)
    participant&.unread_messages_count || 0
  end

  def interlocutor_for(user)
    participants.where.not(id: user.id).first
  end

  def has_participant?(participant)
    if participants.loaded?
      participants.any? { |p| p.id == participant.id }
    else
      participants.exists?(id: participant.id)
    end
  end

  def unread_messages_for(user)
    messages.unread.where.not(sender: user)
  end

  private

  def unique_conversation_between_users
    return unless participants.size == 2

    existing = Conversation.between_users(participants.first, participants.last).exists?
    errors.add(:base, "Conversation already exists between these users") if existing
  end
end
