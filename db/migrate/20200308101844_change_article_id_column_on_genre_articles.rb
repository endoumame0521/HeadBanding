class ChangeArticleIdColumnOnGenreArticles < ActiveRecord::Migration[5.2]
  def change
    change_column_null :genre_articles, :article_id, false
  end
end
