class ChangeMemberIdColumnOnMessages < ActiveRecord::Migration[5.2]
  def change
    change_column_null :messages, :member_id, false
  end
end
