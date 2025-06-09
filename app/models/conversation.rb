class Conversation < ApplicationRecord
  has_many :conversation_participants, dependent: :destroy
  has_many :participants, through: :conversation_participants, source: :user
  has_many :messages, dependent: :destroy

  def last_message
    messages.order(created_at: :desc).first
  end

  def unread_count(user)
    messages.unread.where.not(sender: user).count
  end

  def other_participant(user)
    participants.where.not(id: user.id).first
  end
end
