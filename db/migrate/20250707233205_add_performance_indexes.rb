class AddPerformanceIndexes < ActiveRecord::Migration[8.0]
  def change
    # Composite index for unread message queries
    add_index :messages, [:conversation_id, :read, :sender_id], name: 'index_messages_on_conversation_read_sender'

    # Index for finding latest messages efficiently
    add_index :messages, [:conversation_id, :created_at], order: { created_at: :desc }, name: 'index_messages_on_conversation_created_desc'

    # Index for online users queries
    add_index :users, :last_seen_at, where: "online = true", name: 'index_users_on_last_seen_at_where_online'

    # Index for unread messages partial index
    add_index :messages, [:conversation_id, :sender_id], where: "read = false", name: 'index_messages_unread'

    # Index for conversations ordering
    add_index :conversations, :updated_at, order: { updated_at: :desc }, name: 'index_conversations_on_updated_at_desc'

    # Enable trigram extension for text search (if not already enabled)
    enable_extension 'pg_trgm' unless extension_enabled?('pg_trgm')

    # Add trigram index for user search
    add_index :users, "first_name gin_trgm_ops, last_name gin_trgm_ops, login gin_trgm_ops",
              using: :gin,
              name: 'index_users_on_names_trigram'
  end
end
