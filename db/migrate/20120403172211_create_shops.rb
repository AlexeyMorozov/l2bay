class CreateShops < ActiveRecord::Migration
  db_magic connection: :game

  def change
    create_table :shops do |t|
      t.string :player
      t.boolean :pack
      t.datetime :seen_time
      t.string :location

      t.timestamps
    end

    add_index :shops, [:pack, :seen_time]
  end
end
