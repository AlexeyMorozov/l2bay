class CreateProducts < GameDbMigration
  def change
    create_table :products do |t|
      t.integer :shop_id, null: false
      t.integer :item_id, null: false
      t.integer :count, :limit => 8, null: false
      t.integer :price, :limit => 8, null: false
      t.integer :enchant, null: false
    end
  end
end
