class CreateShops < ActiveRecord::Migration
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
