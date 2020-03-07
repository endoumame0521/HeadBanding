class RemoveDeletedAtFromCities < ActiveRecord::Migration[5.2]
  def change
    remove_column :cities, :deleted_at, :datetime
  end
end
