class ChangeSubjectColumnOnArticles < ActiveRecord::Migration[5.2]
  def change
    change_column_null :articles, :subject, false
  end
end
