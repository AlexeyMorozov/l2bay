class AddServerIdIndexToShops < ActiveRecord::Migration
  def connection
    Shop.connection
  end

  def change
    add_index :shops, :server_id
  end
end
