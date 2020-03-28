class ChangeDatatypeAddressPrefectureOfMembers < ActiveRecord::Migration[5.2]
  def change
    change_column :members, :address_prefecture, :string
  end
end
