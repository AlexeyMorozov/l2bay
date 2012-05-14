class AddIndexToServers < ActiveRecord::Migration
  db_magic connection: :game

  def change
    add_index :servers, :name
  end
end
