class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :conversation

  validates :content, presence: true

  scope :unread, -> { where(read: false) }

  after_create_commit -> { broadcast_message }

  private

  def broadcast_message
    broadcast_append_to conversation,
                       target: "messages",
                       partial: "messages/message",
                       locals: { message: self }
  end
end
