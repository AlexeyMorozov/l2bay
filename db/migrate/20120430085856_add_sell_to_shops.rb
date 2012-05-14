class AddSellToShops < ActiveRecord::Migration
  db_magic connection: :game

  def change
    add_column :shops, :sell, :boolean
  end
end
