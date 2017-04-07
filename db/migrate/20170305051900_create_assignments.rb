class CreateAssignments < ActiveRecord::Migration
  def up
    create_table :assignments do |t|
      t.integer :message_id
      t.integer :account_id
      t.integer :user_id
      t.text :comment
      t.boolean :completed
      t.datetime :completed_at
      t.text :completed_comment
      t.timestamps
    end

    add_index :assignments, [:message_id, :completed]
    add_index :assignments, [:account_id, :completed]
  end

  def down
    drop_table :assignments
  end
end
