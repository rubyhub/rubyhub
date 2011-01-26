class CreateLinkedInAccounts < ActiveRecord::Migration
  def self.up
    create_table :linked_in_accounts do |t|
      t.string :name
      t.string :uid
      t.string :avatar_url
      t.belongs_to :user

      t.timestamps
    end
  end

  def self.down
    drop_table :linked_in_accounts
  end
end
