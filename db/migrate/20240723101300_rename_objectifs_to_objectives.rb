class RenameObjectifsToObjectives < ActiveRecord::Migration[7.1]
  def change
    rename_table :objectifs, :objectives
  end
end
