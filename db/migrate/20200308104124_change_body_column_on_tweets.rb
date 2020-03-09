class ChangeBodyColumnOnTweets < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tweets, :body, false
  end
end
