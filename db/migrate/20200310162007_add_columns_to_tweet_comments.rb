class AddColumnsToTweetComments < ActiveRecord::Migration[5.2]
  def change
    add_column :tweet_comments, :image_id, :string
  end
end
