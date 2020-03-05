class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :member
      t.references :room
      t.text :body
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
