class ChangeMemberIdColumnOnNotices < ActiveRecord::Migration[5.2]
  def change
    change_column_null :notices, :member_id, false
  end
end
