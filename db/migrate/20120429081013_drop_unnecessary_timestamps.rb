class DropUnnecessaryTimestamps < ActiveRecord::Migration
  db_magic connection: :game

  def change
    remove_timestamps :servers
    remove_timestamps :shops
    remove_timestamps :products
  end
end
