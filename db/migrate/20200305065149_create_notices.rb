class CreateNotices < ActiveRecord::Migration[5.2]
  def change
    create_table :notices do |t|
      t.references :member
      t.text :body
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
