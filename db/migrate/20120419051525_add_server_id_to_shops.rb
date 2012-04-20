class AddServerIdToShops < ActiveRecord::Migration
  def change
    add_column :shops, :server_id, :integer

  end
end
