class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :conversation, counter_cache: true

  validates :content, presence: true

  scope :unread, -> { where(read: false) }

  after_create_commit -> { broadcast_message }
  after_create_commit :increment_unread_counters

  private

  def broadcast_message
    broadcast_append_to conversation,
                       target: "messages",
                       partial: "messages/message",
                       locals: { message: self, current_user: nil, conversation: conversation }
  end
  
  def increment_unread_counters
    conversation.conversation_participants
      .where.not(user_id: sender_id)
      .update_all('unread_messages_count = unread_messages_count + 1')
  end
end
