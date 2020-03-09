class ChangeMemberIdColumnOnTweets < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tweets, :member_id, false
  end
end
