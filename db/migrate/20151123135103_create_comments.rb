class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, index: true
      t.references :entry, index: true
      t.timestamps null: false
    end
    add_foreign_key :comments, :users
    add_index :comments, [:user_id, :created_at]
    add_foreign_key :comments, :entries
    add_index :comments, [:entry_id, :created_at]
  end
end
