class ChangeMemberIdColumnOnTweetComments < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tweet_comments, :member_id, false
  end
end
