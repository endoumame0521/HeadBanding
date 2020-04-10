class Announce < ApplicationRecord
  enum action: { not_yet: 0, article_favorite: 1, tweet_favorite: 2, tweet_comment: 3, tweet_comment_favorite: 4, message: 5, follow: 6 }

  belongs_to :article, optional: true
  belongs_to :tweet, optional: true
  belongs_to :tweet_comment, optional: true
  belongs_to :message, optional: true
  belongs_to :announcer, class_name: "Member", optional: true
  belongs_to :reciever, class_name: "Member", optional: true

  # 最新順に並び替え（作成日時）
  default_scope -> { order(created_at: :desc)}

  # Gem kamirariの表示ページ数
  paginates_per 10
end
