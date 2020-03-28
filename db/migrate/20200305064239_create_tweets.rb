class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.references :member
      t.text :body
      t.integer :profile_image_id
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
