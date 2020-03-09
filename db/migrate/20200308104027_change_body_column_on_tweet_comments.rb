class ChangeBodyColumnOnTweetComments < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tweet_comments, :body, false
  end
end
