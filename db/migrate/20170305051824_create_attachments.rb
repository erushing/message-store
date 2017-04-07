class CreateAttachments < ActiveRecord::Migration
  def up
    create_table :attachments do |t|
      t.integer :message_id
      t.integer :account_id
      t.text :preview_url
      t.text :url
      t.string :attachment_type
      t.timestamps
    end

    add_index :attachments, :message_id
  end

  def down
    drop_table :attachments
  end
end
