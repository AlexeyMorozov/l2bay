class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.integer :points, :limit => 8
    end

    add_index :accounts, :user_id
  end
end
