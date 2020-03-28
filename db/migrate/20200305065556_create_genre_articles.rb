class CreateGenreArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :genre_articles do |t|
      t.references :article
      t.references :genre

      t.timestamps
    end
  end
end
