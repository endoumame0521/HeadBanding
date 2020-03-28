class CreateTweetComments < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_comments do |t|
      t.references :member
      t.references :tweet
      t.text :body
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
