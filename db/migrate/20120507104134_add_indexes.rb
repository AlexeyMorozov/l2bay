class AddIndexes < ActiveRecord::Migration
  def connection
    Product.connection
  end

  def change
    remove_index :products, :shop_id
    add_index :products, [:shop_id, :item_id]

    remove_index :shops, [:pack, :seen_time]
    remove_index :shops, :server_id
    add_index :shops, [:server_id, :player], unique: true
    add_index :shops, [:server_id, :pack, :seen_time]
  end
end
