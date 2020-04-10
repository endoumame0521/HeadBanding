class TweetComment < ApplicationRecord
  attachment :image
  belongs_to :member
  belongs_to :tweet
  has_many :tweet_comment_favorites, dependent: :destroy
  has_many :notices, dependent: :destroy
  has_many :announces, dependent: :destroy

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

  # ツイートコメントに対するいいねの通知を作成
  def create_announce_tweet_comment_favorite!(member)
    unless member.id == member_id
      Announce.find_or_create_by(
        announcer_id: member.id,
        reciever_id: member_id,
        tweet_comment_id: id,
        action: "tweet_comment_favorite"
      )
    end
  end
end