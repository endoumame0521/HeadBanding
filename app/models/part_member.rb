class PartMember < ApplicationRecord
  belongs_to :part
  belongs_to :member
end
