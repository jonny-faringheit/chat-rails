class ChangeDateOfBirthFromIntegerToDateInUsers < ActiveRecord::Migration[8.0]
  def up
    remove_column :users, :date_of_birth, :integer
    add_column :users, :date_of_birth, :date, null: true
  end

  def down; end
end
