class TweetComment < ApplicationRecord
  attachment :image
  belongs_to :member
  belongs_to :tweet
  has_many :tweet_comment_favorites, dependent: :destroy
  has_many :notices, dependent: :destroy

  enum status: { enable: true, disable: false }

  # バリデーションSTART------------------------------------------------------------------------------------------
  validates :body, presence: true, length: { maximum: 300 }
  # バリデーションEND--------------------------------------------------------------------------------------------

  # Gem kamirariの表示ページ数
  paginates_per 20

  #ツイートコメントが自分によって既にいいねされていればtrue返す
  def favorited_by?(member)
    tweet_comment_favorites.where(member_id: member.id).any?
  end
end