class RemoveDeletedAtFromPrefectures < ActiveRecord::Migration[5.2]
  def change
    remove_column :prefectures, :deleted_at, :datetime
  end
end
