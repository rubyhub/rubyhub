class AddAvatarUrlToTwitterAccount < ActiveRecord::Migration
  def self.up
    add_column :twitter_accounts, :avatar_url, :string
  end

  def self.down
    remove_column :twitter_accounts, :avatar_url
  end
end
