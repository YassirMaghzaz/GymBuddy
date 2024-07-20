class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :gender
      t.text :location
      t.text :bio
      t.text :availability
      t.string :level

      t.timestamps
    end
  end
end
