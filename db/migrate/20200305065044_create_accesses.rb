class CreateAccesses < ActiveRecord::Migration[5.2]
  def change
    create_table :accesses do |t|
      t.references :visitor
      t.references :visited

      t.timestamps
    end
  end
end
