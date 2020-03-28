class ChangeNameColumnOnGenres < ActiveRecord::Migration[5.2]
  def change
    change_column_null :genres, :name, false
  end
end
