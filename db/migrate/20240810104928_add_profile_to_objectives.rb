class AddProfileToObjectives < ActiveRecord::Migration[7.1]
  def change
    add_reference :objectives, :profile, null: false, foreign_key: true
  end
end
