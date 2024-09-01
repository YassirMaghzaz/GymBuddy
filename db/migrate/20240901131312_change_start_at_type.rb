class ChangeStartAtType < ActiveRecord::Migration[7.1]
  def change
    change_column :objectives, :start_at, :date
  end
end
