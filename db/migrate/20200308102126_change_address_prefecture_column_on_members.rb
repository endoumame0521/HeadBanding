class ChangeAddressPrefectureColumnOnMembers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :members, :address_prefecture, false
  end
end
