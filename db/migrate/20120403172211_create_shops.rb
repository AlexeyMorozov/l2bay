class CreateShops < GameDbMigration
  def change
    create_table :shops do |t|
      t.string :player, null: false
      t.boolean :pack, null: false
      t.boolean :sell, null: false
      t.datetime :seen_time, null: false
      t.integer :server_id, null: false
      t.integer :loc_x, null: false
      t.integer :loc_y, null: false
      t.integer :loc_z, null: false
    end
    add_index :shops, :player
    add_index :shops, :seen_time
  end
end
