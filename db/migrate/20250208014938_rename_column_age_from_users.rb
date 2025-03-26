class RenameColumnAgeFromUsers < ActiveRecord::Migration[8.0]
  reversible do |dir|
    change_table :users do |t|
      dir.up { t.rename :age, :date_of_birth }
      dir.down { t.rename :date_of_birth, :age }
    end
  end
end
