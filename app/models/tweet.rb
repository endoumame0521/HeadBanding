class Tweet < ApplicationRecord
  attachment :image
  belongs_to :member
  has_many :tweet_comments, dependent: :destroy
  has_many :tweet_favorites, dependent: :destroy
  has_many :notices, dependent: :destroy

  enum status: { enable: true, disable: false }

  #ツイートが自分によって既にいいねされていればtrue返す
  def favorited_by?(member)
    tweet_favorites.where(member_id: member.id).any?
  end

  # 最新順に並び替え
  default_scope -> { order(created_at: :desc)}

  #ツイート検索----------------------------------------------------------------------------------
  def self.search(search_params)
    return all if search_params.blank?

    status_is(search_params[:status])
    .body_like(search_params[:body])
  end

  scope :status_is, -> (status) { where(status: status) if status.present? }
  scope :body_like, -> (body) { where('body LIKE ?', "%#{body}%") if body.present? }
end