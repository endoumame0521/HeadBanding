class GenreArticle < ApplicationRecord
  belongs_to :genre
  belongs_to :article
end
