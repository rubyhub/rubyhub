class AddUserIdToTwitterAccountsAndBlogs < ActiveRecord::Migration
  def self.up
    add_column :twitter_accounts, :user_id, :integer
    add_column :blogs, :user_id, :integer
  end

  def self.down
    remove_column :blogs, :user_id
    remove_column :twitter_accounts, :user_id
  end
end
