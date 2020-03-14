class Article < ApplicationRecord
  enum published_status: { open: true, close: false }
  enum category: { recruit: 0, entry: 1 }
  enum day_of_the_week: { saturday: 0, sunday: 1, both: 2, other: 3 }
  enum band_intention: { professional: 0, indies: 1, hobby: 2 }
  enum music_intention: { original:0, copy: 1 }
  enum gender: { male: 0, female: 1 }
  enum band_theme: { beginner: 0, middle: 1, senior: 2, worker: 3 }
  enum status: { enable: true, disable: false }

  belongs_to :member
  belongs_to :prefecture
  has_many :article_favorites, dependent: :destroy
  has_many :genre_articles, dependent: :destroy
  has_many :genres, through: :genre_articles
  has_many :part_articles, dependent: :destroy
  has_many :parts, through: :part_articles
  has_many :article_cities, dependent: :destroy
  has_many :cities, through: :article_cities
  has_many :notices

  def favorited_by?(member)
    article_favorites.where(member_id: member.id).any?
  end
end
