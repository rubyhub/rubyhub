class AddIpAndUseragentToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :ip, :string
    add_column :users, :useragent, :text
  end

  def self.down
    remove_column :users, :useragent
    remove_column :users, :ip
  end
end
