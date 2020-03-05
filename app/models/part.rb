class Part < ApplicationRecord
  has_many :part_members, dependent: :destroy
  has_many :members, through: :part_members
  has_many :part_articles, dependent: :destroy
  has_many :articles, through: :part_articles
end
