class AddGymToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_reference :profiles, :gym, foreign_key: true
  end
end
