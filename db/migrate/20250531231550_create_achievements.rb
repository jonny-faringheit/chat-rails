class CreateAchievements < ActiveRecord::Migration[8.0]
  def change
    create_table :achievements do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :icon, null: false
      t.string :category, null: false
      t.integer :points, default: 0, null: false
      t.string :key, null: false # unique identifier for achievement
      t.integer :tier, default: 1 # bronze: 1, silver: 2, gold: 3, platinum: 4

      t.timestamps
    end

    add_index :achievements, :key, unique: true
    add_index :achievements, :category
  end
end
