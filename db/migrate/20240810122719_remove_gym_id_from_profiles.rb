class RemoveGymIdFromProfiles < ActiveRecord::Migration[7.1]
  def change
    remove_column :profiles, :gym_id, :integer
  end
end
