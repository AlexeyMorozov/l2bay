class AddServerIdIndexToShops < ActiveRecord::Migration
  db_magic connection: :game

  def change
    add_index :shops, :server_id
  end
end
