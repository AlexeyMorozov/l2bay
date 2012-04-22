class AddServerIdToShops < ActiveRecord::Migration
  def connection
    Shop.connection
  end

  def change
    add_column :shops, :server_id, :integer

  end
end
