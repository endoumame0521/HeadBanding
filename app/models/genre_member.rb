class GenreMember < ApplicationRecord
  belongs_to :genre
  belongs_to :member
end
