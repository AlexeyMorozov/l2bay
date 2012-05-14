class CreateProducts < ActiveRecord::Migration
  db_magic connection: :game

  def change
    create_table :products do |t|
      t.integer :shop_id
      t.integer :item_id
      t.integer :count, :limit => 8
      t.integer :price, :limit => 8
      t.integer :enchant

      t.timestamps
    end

    add_index :products, :shop_id
    add_index :products, :item_id
  end
end
