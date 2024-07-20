class AddUserIdToPofiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :user_id, :integer 
    add_index :profiles, :user_id, unique: true 
    add_foreign_key :profiles, :users
  end
end
