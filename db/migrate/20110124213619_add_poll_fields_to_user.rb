class AddPollFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :gender, :string
    add_column :users, :relation_to_ruby, :string
    add_column :users, :os, :string
    add_column :users, :editor, :string
    add_column :users, :birth_year, :integer
    add_column :users, :tabs_or_spaces, :string
  end

  def self.down
    remove_column :users, :tabs_or_spaces
    remove_column :users, :birth_year
    remove_column :users, :editor
    remove_column :users, :os
    remove_column :users, :relation_to_ruby
    remove_column :users, :gender
  end
end
