class AddGymIdToPrefences < ActiveRecord::Migration[7.1]
  def change
    add_column :preferences, :gym_id, :integer, null: false
    add_index :preferences, :gym_id
    add_foreign_key :preferences, :gyms
  end
end
