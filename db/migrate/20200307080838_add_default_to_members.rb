class AddDefaultToMembers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :members, :status, true
  end
end
