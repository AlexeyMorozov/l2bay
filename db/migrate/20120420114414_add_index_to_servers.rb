class AddIndexToServers < ActiveRecord::Migration
  def connection
    Server.connection
  end

  def change
    add_index :servers, :name
  end
end
