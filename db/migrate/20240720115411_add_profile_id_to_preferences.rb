class AddProfileIdToPreferences < ActiveRecord::Migration[7.1]
  def change
    add_column :preferences, :profile_id, :integer, null: false

    add_index :preferences, :profile_id
    add_foreign_key :preferences, :profiles
  end
end
