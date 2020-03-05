class Article < ApplicationRecord
  belongs_to :member
  has_many :article_favorites, dependent: :destroy
  has_many :genre_articles, dependent: :destroy
  has_many :genres, through: :genre_articles
  has_many :part_articles, dependent: :destroy
  has_many :parts, through: :part_articles
end
