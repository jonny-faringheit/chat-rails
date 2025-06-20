class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :conversation, null: false, foreign_key: true
      t.boolean :read, default: false

      t.timestamps
    end

    add_index :messages, :created_at
  end
end
