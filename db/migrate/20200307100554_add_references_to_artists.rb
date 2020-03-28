class AddReferencesToArtists < ActiveRecord::Migration[5.2]
  def change
    add_reference :artists, :member, null: false, foreign_key: true
  end
end
