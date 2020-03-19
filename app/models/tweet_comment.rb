class TweetComment < ApplicationRecord
  attachment :image
  belongs_to :member
  belongs_to :tweet
  has_many :tweet_comment_favorites, dependent: :destroy
  has_many :notices

  enum status: { enable: true, disable: false }

  #ツイートコメントが自分によって既にいいねされていればtrue返す
  def favorited_by?(member)
    tweet_comment_favorites.where(member_id: member.id).any?
  end

  #ツイートコメント検索----------------------------------------------------------------------------------
  def self.search(search_params)
    return where(status: "enable") if search_params.blank?

      where(status: "enable")
      .body_like(search_params[:body])
  end

  scope :body_like, -> (body) { where('body LIKE ?', "%#{body}%") if body.present? }
end