class Access < ApplicationRecord
  belongs_to :visitor, class_name: "Member"
  belongs_to :visited, class_name: "Member"

  # Gem kamirariの表示ページ数
  paginates_per 10

  # 最新順に並び替え
  default_scope -> { order(created_at: :desc)}
end