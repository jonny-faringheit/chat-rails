class AddPerformanceIndexes < ActiveRecord::Migration[8.0]
  def up
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
    execute <<-SQL
      CREATE INDEX index_users_on_names_trigram ON users#{' '}
      USING gin ((COALESCE(first_name, '') || ' ' || COALESCE(last_name, '') || ' ' || COALESCE(login, '')) gin_trgm_ops);
    SQL
  end

  def down
    execute "DROP INDEX IF EXISTS index_users_on_names_trigram;"

    remove_index :conversations, name: 'index_conversations_on_updated_at_desc', if_exists: true
    remove_index :messages, name: 'index_messages_unread', if_exists: true
    remove_index :users, name: 'index_users_on_last_seen_at_where_online', if_exists: true
    remove_index :messages, name: 'index_messages_on_conversation_created_desc', if_exists: true
    remove_index :messages, name: 'index_messages_on_conversation_read_sender', if_exists: true
  end
end
