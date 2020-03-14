class AddDefaultStatusToNotices < ActiveRecord::Migration[5.2]
  def change
    change_column :notices, :status, :integer, default: 0
  end
end
