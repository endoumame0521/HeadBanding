class ChangeGenderColumnOnMembers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :members, :gender, false
  end
end
