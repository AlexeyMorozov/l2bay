class AddIpToServers < ActiveRecord::Migration
  db_magic connection: :game

  def change
    add_column :servers, :ip, :integer
  end
end
