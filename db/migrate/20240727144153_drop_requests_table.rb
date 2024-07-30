class DropRequestsTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :requests
  end

  def down
    # Recreate the table if you need to roll back the migration
    create_table :requests do |t|
      t.integer :sender_profile_id, null: false
      t.integer :receiver_profile_id, null: false
      t.string :status, default: "pending"
      t.timestamps
    end

    add_index :requests, [:sender_profile_id, :receiver_profile_id], unique: true
    add_index :requests, :sender_profile_id
    add_index :requests, :receiver_profile_id

    add_foreign_key :requests, :profiles, column: :sender_profile_id
    add_foreign_key :requests, :profiles, column: :receiver_profile_id
  end
end
