class AddIpToServers < ActiveRecord::Migration
  def connection
    Server.connection
  end

  def change
    add_column :servers, :ip, :integer
  end
end
