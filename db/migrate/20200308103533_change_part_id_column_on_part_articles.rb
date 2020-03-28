class ChangePartIdColumnOnPartArticles < ActiveRecord::Migration[5.2]
  def change
    change_column_null :part_articles, :part_id, false
  end
end
