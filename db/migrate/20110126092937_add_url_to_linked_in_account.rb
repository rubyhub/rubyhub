class AddUrlToLinkedInAccount < ActiveRecord::Migration
  def self.up
    add_column :linked_in_accounts, :url, :string
  end

  def self.down
    remove_column :linked_in_accounts, :url
  end
end
