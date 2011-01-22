class AddTwitteridToTwitterAccount < ActiveRecord::Migration
  def self.up
    add_column :twitter_accounts, :twitterid, :string
  end

  def self.down
    remove_column :twitter_accounts, :twitterid
  end
end
