class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.string :title
    end
  end

  def self.down
    drop_table :regions
  end
end
