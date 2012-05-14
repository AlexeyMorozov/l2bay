class AddIndexes < ActiveRecord::Migration
  db_magic connection: :game

  def up
    remove_index :products, :shop_id
    add_index :products, [:shop_id, :item_id]

    remove_index :shops, [:pack, :seen_time]
    remove_index :shops, :server_id
    add_index :shops, [:server_id, :player], unique: true
    add_index :shops, [:server_id, :pack, :seen_time]
  end

  def down
    add_index :products, :shop_id
    remove_index :products, [:shop_id, :item_id]

    add_index :shops, [:pack, :seen_time]
    add_index :shops, :server_id
    remove_index :shops, [:server_id, :player]
    remove_index :shops, [:server_id, :pack, :seen_time]
  end
end
