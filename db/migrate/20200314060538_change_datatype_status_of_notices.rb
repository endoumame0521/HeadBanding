class ChangeDatatypeStatusOfNotices < ActiveRecord::Migration[5.2]
  def change
    change_column :notices, :status, :integer
  end
end
