class AdaptJobOfferToJooble < ActiveRecord::Migration
  def self.up
    add_column :job_offers, :salary, :string
    add_column :job_offers, :urls, :text
    add_column :job_offers, :joobleid, :string
    add_column :job_offers, :published_on, :date
    remove_column :job_offers, :url
    remove_column :job_offers, :employer
    remove_column :job_offers, :published_at

    create_table :cities_job_offers, :id => false do |t|
      t.integer :city_id
      t.integer :job_offer_id
    end
  end

  def self.down
    drop_table :cities_job_offers

    add_column :job_offers, :published_at, :datetime
    add_column :job_offers, :employer, :string
    add_column :job_offers, :url, :string
    remove_column :job_offers, :published_on
    remove_column :job_offers, :joobleid
    remove_column :job_offers, :urls
    remove_column :job_offers, :salary
  end
end
