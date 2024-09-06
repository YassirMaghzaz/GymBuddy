class AddForeignKeyMatcherIdToMatches < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :matches, :profiles, column: :matcher_id
  end
end
