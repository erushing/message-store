class CreateMessages < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.string :message_type
      t.integer :account_id
      t.integer :channel_id
      t.string :external_id
      t.string :author
      t.string :author_id
      t.text :author_image_url
      t.text :title
      t.text :description
      t.text :body
      t.integer :likes_count, :default => 0
      t.integer :replies_count, :default => 0
      t.integer :shares_count, :default => 0
      t.datetime :posted_at
      t.timestamps
      t.boolean :unread_replies, :default => false
      t.boolean :deleted_replies, :default => false
      t.string :status, :default => 'active'
      t.boolean :read, :default => false
      t.boolean :internal_origin, :default => false
      t.string :mentioned_id
      t.integer :parent_message_id
      t.integer :parent_comment_id
    end unless table_exists? :messages

    unless index_exists?(:messages, :name => 'index_messages_by_channel_id')
      add_index :messages, [:account_id, :status, :posted_at, :channel_id], :name => 'index_messages_by_channel_id'
    end

    unless index_exists?(:messages, :name => 'index_messages_by_channel_id')
      add_index :messages, [:account_id, :status, :posted_at, :message_type], :name => 'index_messages_by_message_type'
    end

  end

  def down
    drop_table :messages if table_exists? :messages
  end
end
