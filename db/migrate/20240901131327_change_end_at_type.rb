class ChangeEndAtType < ActiveRecord::Migration[7.1]
  def change
    change_column :objectives, :end_at, :date
  end
end
