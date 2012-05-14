class AddNewLocationFormatToShops < ActiveRecord::Migration
  db_magic connection: :game

  def change
    add_column :shops, :loc_x, :integer
    add_column :shops, :loc_y, :integer
    add_column :shops, :loc_z, :integer
  end
end
