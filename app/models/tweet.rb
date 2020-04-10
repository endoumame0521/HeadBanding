class Tweet < ApplicationRecord
  attachment :image
  belongs_to :member
  has_many :tweet_comments, dependent: :destroy
  has_many :tweet_favorites, dependent: :destroy
  has_many :notices, dependent: :destroy
  has_many :announces, dependent: :destroy

  enum status: { enable: true, disable: false }

  # バリデーションSTART------------------------------------------------------------------------------------------
  validates :body, presence: true, length: { maximum: 300 }
  # バリデーションEND--------------------------------------------------------------------------------------------

  # Gem kamirariの表示ページ数
  paginates_per 20

  #ツイートが自分によって既にいいねされていればtrue返す
  def favorited_by?(member)
    tweet_favorites.where(member_id: member.id).any?
  end

  # 最新順に並び替え
  default_scope -> { order(created_at: :desc)}

  # ツイートに対するいいねの通知を作成
  def create_announce_tweet_favorite!(member)
    unless member.id == member_id
      Announce.find_or_create_by(
        announcer_id: member.id,
        reciever_id: member_id,
        tweet_id: id,
        action: "tweet_favorite"
      )
    end
  end

  # ツイートに対するコメントの通知を作成
  def create_announce_tweet_comment!(member, tweet_comment_id)
    tweet_comment_member_ids = TweetComment.select(:member_id)
                        .where(tweet_id: id)
                        .where.not(member_id: member.id)
                        .distinct

    # ツイートにコメントした人達への通知を作成
    tweet_comment_member_ids.each do |tweet_comment_member_id|
      save_announce_tweet_comment!(member, tweet_comment_id, tweet_comment_member_id['member_id'])
    end

    # コメントされたツイートをした人への通知を作成
    save_announce_tweet_comment!(member, tweet_comment_id, member_id)
  end

  # ツイートに対するコメントの通知をセーブ
  def save_announce_tweet_comment!(member, tweet_comment_id, reciever_id)
    unless member.id == reciever_id
      announce = Announce.create(
        announcer_id: member.id,
        reciever_id: reciever_id,
        tweet_id: id,
        tweet_comment_id: tweet_comment_id,
        action: "tweet_comment"
      )
    end
  end

  #ツイート検索----------------------------------------------------------------------------------
  def self.search(search_params)
    return all if search_params.blank?

    status_is(search_params[:status])
    .body_like(search_params[:body])
  end

  scope :status_is, -> (status) { where(status: status) if status.present? }
  scope :body_like, -> (body) { where('body LIKE ?', "%#{body}%") if body.present? }
end