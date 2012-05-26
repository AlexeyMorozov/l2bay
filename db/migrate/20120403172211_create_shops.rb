class CreateShops < GameDbMigration
  def change
    create_table :shops do |t|
      t.string :player
      t.boolean :pack
      t.boolean :sell
      t.datetime :seen_time
      t.integer :server_id
      t.integer :loc_x
      t.integer :loc_y
      t.integer :loc_z
    end
  end
end
