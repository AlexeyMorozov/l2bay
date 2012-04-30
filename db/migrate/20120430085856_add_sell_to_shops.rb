class AddSellToShops < ActiveRecord::Migration
  def connection
    Shop.connection
  end

  def change
    add_column :shops, :sell, :boolean
  end
end
