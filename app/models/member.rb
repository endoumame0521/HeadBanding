class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  enum gender: { male: 0, female: 1 }
  enum status: { enable: true, disable: false }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  has_many :articles, dependent: :destroy
  has_many :article_favorites, dependent: :destroy
  has_many :favorited_articles, through: :article_favorites, source: :article #特定の会員がお気に入りした記事だけを取得する為
  has_many :tweets, dependent: :destroy
  has_many :tweet_comments, dependent: :destroy
  has_many :tweet_comment_favorites, dependent: :destroy
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
  has_many :follower_member, through: :followed, source: :follower # 自分をフォローしている人
  has_many :following_member, through: :follower, source: :followed # 自分がフォローしている人
  has_many :visitor, class_name: "Access", foreign_key: "visitor_id", dependent: :destroy #自分の足跡をつけた人を取得
  has_many :visited, class_name: "Access", foreign_key: "visited_id", dependent: :destroy #足跡をつけられた人を取得
  has_many :visitor_member, through: :visited, source: :visitor #自分に足跡をつけた人
  has_many :visited_member, through: :visitor, source: :visited #自分が足跡をつけた人

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

  #会員の生年月日から年齢を計算
  def age
    (Date.today.strftime("%Y%m%d").to_i - birthday.strftime("%Y%m%d").to_i) / 10000
  end

  #会員のステータスが有効かどうか確認し、有効でなければログイン出来無い
  def active_for_authentication?
    super && (self.enable?)
  end

end
