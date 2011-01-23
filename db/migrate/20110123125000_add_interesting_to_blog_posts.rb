class AddInterestingToBlogPosts < ActiveRecord::Migration
  def self.up
    add_column :blog_posts, :interesting, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :blog_posts, :interesting
  end
end
