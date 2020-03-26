class Part < ApplicationRecord
  has_many :part_members, dependent: :destroy
  has_many :members, through: :part_members
  has_many :part_articles, dependent: :destroy
  has_many :articles, through: :part_articles

  enum status: { enable: true, disable: false }

  # バリデーションSTART------------------------------------------------------------------------------------------
  validates :name, presence: true, length: { maximum: 100 }
  # バリデーションEND--------------------------------------------------------------------------------------------

  # 最新順に並び替え
  default_scope -> { order(created_at: :desc)}
end
