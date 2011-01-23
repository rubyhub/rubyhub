class AddUsersCountToCities < ActiveRecord::Migration
  def self.up
    add_column :cities, :users_count, :integer, :default => 0
  end

  def self.down
    remove_column :cities, :users_count
  end
end
