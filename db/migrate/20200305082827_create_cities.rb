class CreateCities < ActiveRecord::Migration[5.2]
    def change
        create_table :cities, id: :int, unsigned: true, auto_increment: true, options: 'ENGINE=InnoDB COLLATE=utf8_general_ci' do |t|
            t.integer :prefecture_id
            t.string :name, null: false, limit: 16

            t.datetime :created_at
            t.datetime :updated_at
            t.datetime :deleted_at
        end
    end
end