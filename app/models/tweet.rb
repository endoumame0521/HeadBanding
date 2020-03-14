class Tweet < ApplicationRecord
  attachment :image
  belongs_to :member
  has_many :tweet_comments, dependent: :destroy
  has_many :tweet_favorites, dependent: :destroy
  has_many :notices

  enum status: { enable: true, disable: false }

  def favorited_by?(member)
    tweet_favorites.where(member_id: member.id).any?
  end
end