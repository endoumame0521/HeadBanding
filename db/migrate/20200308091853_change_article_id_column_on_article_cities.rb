class ChangeArticleIdColumnOnArticleCities < ActiveRecord::Migration[5.2]
  def change
    change_column_null :article_cities, :article_id, false
  end
end
