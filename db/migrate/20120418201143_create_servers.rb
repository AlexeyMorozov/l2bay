class CreateServers < GameDbMigration
  def change
    create_table :servers do |t|
      t.string :name, null: false
      t.integer :ip, null: false
    end
  end
end
