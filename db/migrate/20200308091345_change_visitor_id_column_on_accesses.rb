class ChangeVisitorIdColumnOnAccesses < ActiveRecord::Migration[5.2]
  def change
    change_column_null :accesses, :visitor_id, false
  end
end
