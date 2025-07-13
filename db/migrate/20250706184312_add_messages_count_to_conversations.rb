class AddMessagesCountToConversations < ActiveRecord::Migration[8.0]
  def change
    add_column :conversations, :messages_count, :integer, default: 0, null: false

    # Update existing records
    reversible do |dir|
      dir.up do
        Conversation.find_each do |conversation|
          Conversation.reset_counters(conversation.id, :messages)
        end
      end
    end
  end
end
