class ChangeBirthdayColumnOnMembers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :members, :birthday, false
  end
end
