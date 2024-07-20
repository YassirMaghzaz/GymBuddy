class AddProfileIdToObjectifs < ActiveRecord::Migration[7.1]
  def change
    add_column :objectifs, :profile_id, :integer, null: false
    add_index :objectifs, :profile_id
    add_foreign_key :objectifs, :profiles
  end
end
