class CreateLabels < ActiveRecord::Migration
  def up
    create_table :labels do |t|
      t.integer :message_id
      t.string :label
      t.integer :account_id
      t.timestamps
    end

    add_index :labels, :message_id
    add_index :labels, :account_id
  end

  def down
    drop_table :labels
  end
end
