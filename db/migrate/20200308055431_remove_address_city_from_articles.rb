class RemoveAddressCityFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :address_city, :string
  end
end
