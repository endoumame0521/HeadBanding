class ChangeMemberIdColumnOnGenreMembers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :genre_members, :member_id, false
  end
end
