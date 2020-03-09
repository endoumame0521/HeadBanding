class ChangeMemberIdColumnOnArticles < ActiveRecord::Migration[5.2]
  def change
    change_column_null :articles, :member_id, false
  end
end
