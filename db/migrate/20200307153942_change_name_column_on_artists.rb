class ChangeNameColumnOnArtists < ActiveRecord::Migration[5.2]
  def change
    change_column_null :artists, :name, false
  end
end
