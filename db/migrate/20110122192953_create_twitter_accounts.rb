class CreateTwitterAccounts < ActiveRecord::Migration
  def self.up
    create_table :twitter_accounts do |t|
      t.string :name
      t.string :status

      t.timestamps
    end

    add_column :tweets, :account_id, :integer
    remove_column :tweets, :author
  end

  def self.down
    add_column :tweets, :author, :string
    remove_column :tweets, :account_id

    drop_table :twitter_accounts
  end
end
