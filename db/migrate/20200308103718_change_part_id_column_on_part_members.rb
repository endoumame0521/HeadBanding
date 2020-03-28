class ChangePartIdColumnOnPartMembers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :part_members, :part_id, false
  end
end
