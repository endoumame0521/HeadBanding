class ChangeBodyColumnOnMessages < ActiveRecord::Migration[5.2]
  def change
    change_column_null :messages, :body, false
  end
end
