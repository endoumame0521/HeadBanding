class ChangeAddressCityColumnOnMembers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :members, :address_city, false
  end
end
