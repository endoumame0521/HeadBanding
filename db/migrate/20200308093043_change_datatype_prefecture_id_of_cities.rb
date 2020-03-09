class ChangeDatatypePrefectureIdOfCities < ActiveRecord::Migration[5.2]
  def change
    change_column :cities, :prefecture_id, :bigint
  end
end
