class Prefecture < ApplicationRecord
  has_many :cities
  has_many :articles
end
