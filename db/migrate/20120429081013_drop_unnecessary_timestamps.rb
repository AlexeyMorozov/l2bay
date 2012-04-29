class DropUnnecessaryTimestamps < ActiveRecord::Migration
  def connection
    Shop.connection
  end

  def change
    remove_timestamps :servers
    remove_timestamps :shops
    remove_timestamps :products
  end
end
