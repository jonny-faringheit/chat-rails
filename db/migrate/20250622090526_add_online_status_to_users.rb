class AddOnlineStatusToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :online, :boolean, default: false, null: false
    add_column :users, :last_seen_at, :datetime

    add_index :users, :online
  end
end
