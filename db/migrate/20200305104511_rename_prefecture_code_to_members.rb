class RenamePrefectureCodeToMembers < ActiveRecord::Migration[5.2]
  def change
    rename_column :members, :prefecture_code, :address_prefecture
  end
end
