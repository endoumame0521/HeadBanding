class ChangeNameColumnOnParts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :parts, :name, false
  end
end
