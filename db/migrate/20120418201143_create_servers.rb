class CreateServers < ActiveRecord::Migration
  db_magic connection: :game

  def change
    create_table :servers do |t|
      t.string :name
      t.integer :ip
    end
  end
end
