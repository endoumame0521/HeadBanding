class ArticleFavorite < ApplicationRecord
  belongs_to :member
  belongs_to :article
end
