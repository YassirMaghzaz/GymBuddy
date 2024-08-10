class CreateProfileImages < ActiveRecord::Migration[7.1]
  def change
    create_table :profile_images do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
