class DeleteLocationFromShops < ActiveRecord::Migration
  def connection
    Shop.connection
  end

  def up
    remove_column :shops, :location
  end

  def down
    add_column :shops, :location, :string
  end
end
