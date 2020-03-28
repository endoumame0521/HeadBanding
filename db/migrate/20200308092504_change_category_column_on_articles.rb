class ChangeCategoryColumnOnArticles < ActiveRecord::Migration[5.2]
  def change
    change_column_null :articles, :category, false
  end
end
