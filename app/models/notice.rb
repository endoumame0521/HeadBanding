class Notice < ApplicationRecord
  belongs_to :member
  belongs_to :tweet, optional: true
  belongs_to :tweet_comment, optional: true
  belongs_to :article, optional: true

  enum status: { checking: 0, confirmed: 1, missreporting: 2 }

  # バリデーションSTART------------------------------------------------------------------------------------------
  validates :body, presence: true, length: { maximum: 5000 }
  # バリデーションEND--------------------------------------------------------------------------------------------

  # 最新順に並び替え
  default_scope -> { order(created_at: :desc)}
end
