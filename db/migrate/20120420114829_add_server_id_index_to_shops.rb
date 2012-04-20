class AddServerIdIndexToShops < ActiveRecord::Migration
  def change
    add_index :shops, :server_id
  end
end
