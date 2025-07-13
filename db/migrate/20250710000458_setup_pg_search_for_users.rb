class SetupPgSearchForUsers < ActiveRecord::Migration[8.0]
  def up
    # Удаляем старый составной триграммный индекс
    execute "DROP INDEX IF EXISTS index_users_on_names_trigram;"

    # Включаем необходимые расширения для pg_search
    enable_extension 'pg_trgm' unless extension_enabled?('pg_trgm')
    enable_extension 'unaccent' unless extension_enabled?('unaccent')

    # Создаем отдельные триграммные индексы для каждого поля
    add_index :users, :first_name, using: :gin, opclass: :gin_trgm_ops, name: 'index_users_on_first_name_trigram'
    add_index :users, :last_name, using: :gin, opclass: :gin_trgm_ops, name: 'index_users_on_last_name_trigram'
    add_index :users, :login, using: :gin, opclass: :gin_trgm_ops, name: 'index_users_on_login_trigram'
  end

  def down
    remove_index :users, name: 'index_users_on_first_name_trigram', if_exists: true
    remove_index :users, name: 'index_users_on_last_name_trigram', if_exists: true
    remove_index :users, name: 'index_users_on_login_trigram', if_exists: true

    # Восстанавливаем старый составной индекс
    execute <<-SQL
      CREATE INDEX index_users_on_names_trigram ON users#{' '}
      USING gin ((COALESCE(first_name, '') || ' ' || COALESCE(last_name, '') || ' ' || COALESCE(login, '')) gin_trgm_ops);
    SQL
  end
end
