class AddServerIdToShops < ActiveRecord::Migration
  db_magic connection: :game

  def change
    add_column :shops, :server_id, :integer

  end
end
