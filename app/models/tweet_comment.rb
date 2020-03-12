class TweetComment < ApplicationRecord
  attachment :image
  belongs_to :member
  belongs_to :tweet
  has_many :tweet_comment_favorites, dependent: :destroy

  enum status: { enable: true, disable: false }

  def favorited_by?(member)
    tweet_comment_favorites.where(member_id: member.id).any?
  end
end
