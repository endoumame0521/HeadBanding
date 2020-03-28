class CreateTweetFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_favorites do |t|
      t.references :member
      t.references :tweet

      t.timestamps
    end
  end
end
