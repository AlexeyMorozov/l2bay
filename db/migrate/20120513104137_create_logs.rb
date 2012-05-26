class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id, null: false
      t.integer :log_type, null: false
      t.binary :data, null: false
      t.datetime :created_at, null: false
    end
  end
end
