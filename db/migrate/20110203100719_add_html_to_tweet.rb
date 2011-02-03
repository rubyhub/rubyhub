class AddHtmlToTweet < ActiveRecord::Migration
  def self.up
    add_column :tweets, :html, :text
  end

  def self.down
    remove_column :tweets, :html
  end
end
