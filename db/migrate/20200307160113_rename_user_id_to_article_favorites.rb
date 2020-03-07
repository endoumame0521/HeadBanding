class RenameUserIdToArticleFavorites < ActiveRecord::Migration[5.2]
  def change
    rename_column :article_favorites, :user_id, :member_id
  end
end
