class CreateTweetCommentFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_comment_favorites do |t|
      t.references :member, foreign_key: true
      t.references :tweet_comment, foreign_key: true

      t.timestamps
    end
  end
end
