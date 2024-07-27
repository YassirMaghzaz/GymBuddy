class RemoveIntensityLevelFromPreferences < ActiveRecord::Migration[7.1]
  def change
    remove_column :preferences, :intensity_level, :string
  end
end
