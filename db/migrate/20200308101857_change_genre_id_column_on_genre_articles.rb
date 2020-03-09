class ChangeGenreIdColumnOnGenreArticles < ActiveRecord::Migration[5.2]
  def change
    change_column_null :genre_articles, :genre_id, false
  end
end
