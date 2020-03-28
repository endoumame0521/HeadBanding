class CreatePartArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :part_articles do |t|
      t.references :member
      t.references :article

      t.timestamps
    end
  end
end
