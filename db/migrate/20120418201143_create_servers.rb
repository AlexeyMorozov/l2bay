class CreateServers < GameDbMigration
  def change
    create_table :servers do |t|
      t.string :name, null: false
      t.integer :ip, null: false
    end
    add_index :servers, :name
    add_index :servers, :ip
  end
end
