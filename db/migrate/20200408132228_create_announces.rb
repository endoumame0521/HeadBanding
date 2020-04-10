class CreateAnnounces < ActiveRecord::Migration[5.2]
  def change
    create_table :announces do |t|
      t.integer :announcer_id, null: false
      t.integer :reciever_id, null: false
      t.references :article
      t.references :tweet
      t.references :tweet_comment
      t.references :message
      t.integer :action, default: 0, null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
