class DeleteLocationFromShops < ActiveRecord::Migration
  db_magic connection: :game

  def up
    remove_column :shops, :location
  end

  def down
    add_column :shops, :location, :string
  end
end
