class RemoveReferenceFromPreferences < ActiveRecord::Migration[7.1]
  def change
    remove_reference :preferences, :gym, foreign_key: true
  end
end
