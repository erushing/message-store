class CreateActivities < ActiveRecord::Migration
  def up
    create_table :activities do |t|
      t.integer :message_id
      t.integer :account_id
      t.string :activity
      t.text :description
      t.integer :user_id
      t.timestamps
    end

    add_index :activities, :message_id
  end

  def down
    drop_table :activities
  end
end
