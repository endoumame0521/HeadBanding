class RemovePrefectureIdFromCities < ActiveRecord::Migration[5.2]
  def change
    remove_column :cities, :prefecture_id, :bigint
  end
end
