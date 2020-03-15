class CreateBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :blocks do |t|
      t.references :blocker
      t.references :blocked

      t.timestamps
    end
  end
end
