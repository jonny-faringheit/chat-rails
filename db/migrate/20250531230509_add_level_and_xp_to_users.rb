class AddLevelAndXpToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :level, :integer, default: 1, null: false
    add_column :users, :current_xp, :integer, default: 0, null: false

    add_index :users, :level
    add_index :users, :current_xp
  end
end
