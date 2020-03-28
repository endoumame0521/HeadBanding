class ChangeGenreIdColumnOnGenreMembers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :genre_members, :genre_id, false
  end
end
