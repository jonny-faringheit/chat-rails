class AddUnreadMessagesCounterCache < ActiveRecord::Migration[8.0]
  def up
    # Add counter cache column
    add_column :conversation_participants, :unread_messages_count, :integer, default: 0, null: false

    # Populate existing counts
    ConversationParticipant.find_each do |participant|
      count = Message.where(conversation_id: participant.conversation_id)
                    .where.not(sender_id: participant.user_id)
                    .where(read: false)
                    .count
      participant.update_column(:unread_messages_count, count)
    end
  end

  def down
    remove_column :conversation_participants, :unread_messages_count
  end
end
