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
  has_many :entry_rooms, through: :entries, source: :room #特定の会員が参加したメッセージルームを取得する
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
  has_many :visiting_member, through: :visitor, source: :visited #自分が足跡をつけた人
  has_many :blocker, class_name: "Block", foreign_key: "blocker_id", dependent: :destroy #ブロックしている人を取得
  has_many :blocked, class_name: "Block", foreign_key: "blocked_id", dependent: :destroy #ブロックされている人を取得
  has_many :blocker_member, through: :blocked, source: :blocker #自分をブロックした人
  has_many :blocking_member, through: :blocker, source: :blocked #自分がブロックしている人

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

  #メンバーをブロックする
  def block(member_id)
    blocker.create(blocked_id: member_id)
  end

  #メンバーのブロックを外す
  def unblock(member_id)
    blocker.find_by(blocked_id: member_id).destroy
  end

  # ブロックしていればtrueを返す
  def blocking?(member)
    blocking_member.include?(member)
  end

  #会員登録後、年齢を誕生日から計算してageカラムに保存
  after_create_commit { self.update(age: self.age) }
  #会員の生年月日から年齢を計算
  def age
    (Date.today.strftime("%Y%m%d").to_i - birthday.strftime("%Y%m%d").to_i) / 10000
  end

  #会員のステータスが有効かどうか確認し、有効でなければログイン出来無い
  def active_for_authentication?
    super && (self.enable?)
  end

  #会員検索----------------------------------------------------------------------------------
  def self.search(search_params)
    return where(status: "enable") if search_params.blank?

      where(status: "enable")
      .name_like(search_params[:name])
      .gender_is(search_params[:gender])
      .age_min(search_params[:age_min])
      .age_max(search_params[:age_max])
      .address_prefecture_is(search_params[:address_prefecture_ids])
      .address_city_is(search_params[:address_city_ids])
      .part_is(search_params[:part_ids])
      .genre_is(search_params[:genre_ids])
      .artist_like(search_params[:artists])
  end

  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :gender_is, -> (gender) { where(gender: gender) if gender.present? }
  scope :age_min, -> (min) { where('? <= age', min) if min.present? }
  scope :age_max, -> (max) { where('age <= ?', max) if max.present? }

  scope :address_prefecture_is, -> (prefecture) do
    where(address_prefecture: Prefecture.where(id: prefecture).map{|k| k.name}) unless prefecture[1].nil?
  end

  scope :address_city_is, -> (city) do
    where(address_city: City.where(id: city).map{|k| k.name}) unless city[1].nil?
  end

  scope :part_is, -> (part) do
    unless part[1].nil?
      member_ids = PartMember.where(part_id: part).map{|k| k.member_id}
      where(id: member_ids)
    end
  end

  scope :genre_is, -> (genre) do
    unless genre[1].nil?
      member_ids = GenreMember.where(genre_id: genre).map{|k| k.member_id}
      where(id: member_ids)
    end
  end

  scope :artist_like, -> (artist) do
    unless artist[:name].blank?
      member_ids = Artist.where('name LIKE?', "%#{artist[:name]}%").map{|k| k.member_id}
      where(id: member_ids)
    end
  end
end
