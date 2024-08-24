class AddProfileToGyms < ActiveRecord::Migration[7.1]
  def change
    add_reference :gyms, :profile, null: false, foreign_key: true
  end
end
