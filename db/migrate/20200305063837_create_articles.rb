class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.references :member
      t.integer :published_status
      t.integer :category
      t.string :subject
      t.text :body
      t.integer :prefecture_code
      t.string :address_city
      t.integer :day_of_the_week
      t.integer :band_intention
      t.integer :music_intention
      t.integer :gender
      t.integer :age_min
      t.integer :age_max
      t.string :sound
      t.integer :band_theme
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end