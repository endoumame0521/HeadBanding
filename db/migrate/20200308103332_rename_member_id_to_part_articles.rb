class RenameMemberIdToPartArticles < ActiveRecord::Migration[5.2]
  def change
    rename_column :part_articles, :member_id, :part_id
  end
end
