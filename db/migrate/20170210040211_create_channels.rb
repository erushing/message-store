class CreateChannels < ActiveRecord::Migration
  def up
    create_table :channels do |t|
      t.string :name
      t.integer :account_id
      t.string :channel_type
      t.string :status
      t.timestamps
    end
  end

  def down
    drop_table :channels
  end
end
