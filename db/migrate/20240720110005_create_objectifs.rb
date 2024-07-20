class CreateObjectifs < ActiveRecord::Migration[7.1]
  def change
    create_table :objectifs do |t|
      t.string :title
      t.text :description
      t.string :status
      t.float :progress
      t.timestamp :start_at
      t.timestamp :end_at
      t.float :target_weight
      t.float :current_weight

      t.timestamps
    end
  end
end
