class ChangeLatLongType < ActiveRecord::Migration
  def self.up
   change_column :capsuls, :latitude, :float
   change_column :capsuls, :longitude, :float
  end

  def self.down
   change_column :capsuls, :latitude, :integer
   change_column :capsuls, :longitude, :integer
  end
end
