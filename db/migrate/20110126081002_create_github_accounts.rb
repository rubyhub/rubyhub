class CreateGithubAccounts < ActiveRecord::Migration
  def self.up
    create_table :github_accounts do |t|
      t.belongs_to :user
      t.string :name
      t.string :githubid

      t.timestamps
    end
  end

  def self.down
    drop_table :github_accounts
  end
end
