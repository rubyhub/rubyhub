class GeneralizeFieldsInAccounts < ActiveRecord::Migration
  def self.up
    rename_column :twitter_accounts, :twitterid, :uid
    rename_column :github_accounts, :githubid, :uid
    add_column :github_accounts, :avatar_url, :string
  end

  def self.down
    remove_column :github_accounts, :avatar_url
    rename_column :github_accounts, :uid, :githubid
    rename_column :twitter_accounts, :uid, :twitterid
  end
end
