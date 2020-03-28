class ChangeBodyColumnOnNotices < ActiveRecord::Migration[5.2]
  def change
    change_column_null :notices, :body, false
  end
end
