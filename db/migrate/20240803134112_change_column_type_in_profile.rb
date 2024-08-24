class ChangeColumnTypeInProfile < ActiveRecord::Migration[7.1]
  def up
    change_column :profiles, :location, :string
  end

  def down
    change_column :profiles, :location, :text
  end
end
