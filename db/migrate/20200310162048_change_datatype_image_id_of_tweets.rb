class ChangeDatatypeImageIdOfTweets < ActiveRecord::Migration[5.2]
  def change
    change_column :tweets, :image_id, :string
  end
end
