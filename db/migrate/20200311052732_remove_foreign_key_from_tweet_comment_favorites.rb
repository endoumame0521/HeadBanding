class RemoveForeignKeyFromTweetCommentFavorites < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key "tweet_comment_favorites", "members"
    remove_foreign_key "tweet_comment_favorites", "tweet_comments"
  end
end
