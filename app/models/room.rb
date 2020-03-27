class Room < ApplicationRecord
  enum status: { enable: true, disable: false }

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :members, through: :entries
  has_many :entry_members, through: :entries, source: :member

  # Gem kamirariの表示ページ数
  paginates_per 10

  # 最新順に並び替え
  default_scope -> { order(created_at: :desc)}
end
