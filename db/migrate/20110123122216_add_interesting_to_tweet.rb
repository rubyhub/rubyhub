class AddInterestingToTweet < ActiveRecord::Migration
  def self.up
    add_column :tweets, :interesting, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :tweets, :interesting
  end
end
