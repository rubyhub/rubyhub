class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.belongs_to :region
      t.float :lat
      t.float :lon
      t.string :title
    end
  end

  def self.down
    drop_table :cities
  end
end
