class ChangeMemberIdColumnOnEnries < ActiveRecord::Migration[5.2]
  def change
    change_column_null :entries, :member_id, false
  end
end
