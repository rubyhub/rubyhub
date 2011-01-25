class AddExperienceToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :heard_about_ruby_year, :integer
    add_column :users, :started_ruby_year, :integer
  end

  def self.down
    remove_column :users, :started_ruby_year
    remove_column :users, :heard_about_ruby_year
  end
end
