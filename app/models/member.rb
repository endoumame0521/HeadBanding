class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  enum gender: { 男性: 0, 女性: 1 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  has_many :articles, dependent: :destroy
  has_many :article_favorites, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :tweet_comments, dependent: :destroy
  has_many :tweet_favorites, dependent: :destroy
  has_many :notices, dependent: :destroy
  has_many :artists, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries
  has_many :genre_members, dependent: :destroy
  has_many :genres, through: :genre_members
  has_many :part_members, dependent: :destroy
  has_many :parts, through: :part_members
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_member, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_member, through: :followed, source: :follower # 自分をフォローしている人

  accepts_nested_attributes_for :artists

  #メンバーをフォローする
  def follow(member_id)
    follower.create(followed_id: member_id)
  end
  #メンバーのフォローを外す
  def unfollow(member_id)
    follower.find_by(followed_id: member_id).destroy
  end
  # フォローしていればtrueを返す
  def following?(member)
    following_member.include?(member)
  end

end
