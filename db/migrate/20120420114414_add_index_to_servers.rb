class AddIndexToServers < ActiveRecord::Migration
  def change
    add_index :servers, :name
  end
end
