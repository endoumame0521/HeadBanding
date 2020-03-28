class ChangeMemberIdColumnOnPartMembers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :part_members, :member_id, false
  end
end
