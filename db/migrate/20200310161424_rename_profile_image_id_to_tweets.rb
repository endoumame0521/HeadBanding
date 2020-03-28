class RenameProfileImageIdToTweets < ActiveRecord::Migration[5.2]
  def change
    rename_column :tweets, :profile_image_id, :image_id
  end
end
