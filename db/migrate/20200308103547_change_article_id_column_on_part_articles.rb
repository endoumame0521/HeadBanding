class ChangeArticleIdColumnOnPartArticles < ActiveRecord::Migration[5.2]
  def change
    change_column_null :part_articles, :article_id, false
  end
end
