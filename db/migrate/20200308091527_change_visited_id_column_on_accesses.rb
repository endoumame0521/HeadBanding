class ChangeVisitedIdColumnOnAccesses < ActiveRecord::Migration[5.2]
  def change
    change_column_null :accesses, :visited_id, false
  end
end
