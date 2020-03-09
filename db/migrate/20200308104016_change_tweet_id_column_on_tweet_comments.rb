class ChangeTweetIdColumnOnTweetComments < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tweet_comments, :tweet_id, false
  end
end
