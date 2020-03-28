class CreateGenreMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :genre_members do |t|
      t.references :member
      t.references :genre

      t.timestamps
    end
  end
end
