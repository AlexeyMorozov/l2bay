class CreateProducts < ActiveRecord::Migration
  db_magic connection: :game

  def change
    create_table :products do |t|
      t.integer :shop_id
      t.integer :item_id
      t.integer :count, :limit => 8
      t.integer :price, :limit => 8
      t.integer :enchant
    end
  end
end
