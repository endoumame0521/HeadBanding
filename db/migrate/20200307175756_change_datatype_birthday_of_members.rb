class ChangeDatatypeBirthdayOfMembers < ActiveRecord::Migration[5.2]
  def change
    change_column :members, :birthday, :date
  end
end
