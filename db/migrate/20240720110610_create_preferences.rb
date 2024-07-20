class CreatePreferences < ActiveRecord::Migration[7.1]
  def change
    create_table :preferences do |t|
      t.time :workout_time
      t.string :workout_days
      t.string :workout_type
      t.string :intensity_level
      t.string :equipment

      t.timestamps
    end
  end
end
