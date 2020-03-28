class CreatePartMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :part_members do |t|
      t.references :member
      t.references :part

      t.timestamps
    end
  end
end
