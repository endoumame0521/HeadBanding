class ArticleCity < ApplicationRecord
  belongs_to :article
  belongs_to :city
end
