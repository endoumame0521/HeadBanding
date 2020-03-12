class Genre < ApplicationRecord
  has_many :genre_members, dependent: :destroy
  has_many :members, through: :genre_members
  has_many :genre_articles, dependent: :destroy
  has_many :articles, through: :genre_articles

  enum status: { enable: true, disable: false }
end
