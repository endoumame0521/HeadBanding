class PartArticle < ApplicationRecord
  belongs_to :part
  belongs_to :article
end
