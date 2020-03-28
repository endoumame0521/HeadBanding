class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
