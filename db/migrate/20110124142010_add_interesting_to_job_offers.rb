class AddInterestingToJobOffers < ActiveRecord::Migration
  def self.up
    add_column :job_offers, :interesting, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :job_offers, :interesting
  end
end
