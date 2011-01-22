class AddUrlToBlog < ActiveRecord::Migration
  def self.up
    add_column :blogs, :url, :string
  end

  def self.down
    remove_column :blogs, :url
  end
end
