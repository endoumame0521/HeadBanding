class City < ApplicationRecord
  belongs_to :prefecture
  has_many :article_cities, dependent: :destroy
  has_many :articles, through: :article_cities
end
