class CreateAccounts < ActiveRecord::Migration
  def up
    create_table :accounts do |t|
      t.string :name
      t.string :status
      t.timestamps
    end
  end

  def down
    drop_table :accounts
  end
end
