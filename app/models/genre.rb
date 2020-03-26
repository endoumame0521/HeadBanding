class Genre < ApplicationRecord
  has_many :genre_members, dependent: :destroy
  has_many :members, through: :genre_members
  has_many :genre_articles, dependent: :destroy
  has_many :articles, through: :genre_articles

  enum status: { enable: true, disable: false }

  # バリデーションSTART------------------------------------------------------------------------------------------
  validates :name, presence: true, length: { maximum: 100 }
  # バリデーションEND--------------------------------------------------------------------------------------------

  # 最新順に並び替え
  default_scope -> { order(created_at: :desc)}
end
