class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id, null: false
      t.integer :points, :limit => 8, null: false, default: 0
    end
  end
end
