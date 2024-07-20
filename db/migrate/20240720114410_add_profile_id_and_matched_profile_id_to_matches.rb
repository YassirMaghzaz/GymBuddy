class AddProfileIdAndMatchedProfileIdToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :profile_id, :integer
    add_column :matches, :matched_profile_id, :integer
    
    add_index :matches, :profile_id
    add_index :matches, :matched_profile_id
    add_index :matches, [:profile_id, :matched_profile_id], unique: true

    add_foreign_key :matches, :profiles, column: :profile_id
    add_foreign_key :matches, :profiles, column: :matched_profile_id
  end
end
