class ChangeDatatypePublishedStatusOfArticles < ActiveRecord::Migration[5.2]
  def change
    change_column :articles, :published_status, :boolean
  end
end
