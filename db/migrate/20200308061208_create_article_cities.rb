class CreateArticleCities < ActiveRecord::Migration[5.2]
  def change
    create_table :article_cities do |t|
      t.references :article
      t.references :city

      t.timestamps
    end
  end
end
