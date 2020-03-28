class ChangePublishedStatusColumnOnArticles < ActiveRecord::Migration[5.2]
  def change
    change_column_null :articles, :published_status, false
    change_column :articles, :published_status, :boolean, default: true
  end
end
