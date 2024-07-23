class RemoveWorkoutTimeFromPreferences < ActiveRecord::Migration[7.1]
  def change
    remove_column :preferences, :workout_time, :time
  end
end
