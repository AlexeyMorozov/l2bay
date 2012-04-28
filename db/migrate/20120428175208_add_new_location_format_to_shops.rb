class AddNewLocationFormatToShops < ActiveRecord::Migration
  def connection
    Shop.connection
  end

  def change
    add_column :shops, :loc_x, :integer
    add_column :shops, :loc_y, :integer
    add_column :shops, :loc_z, :integer
  end
end
