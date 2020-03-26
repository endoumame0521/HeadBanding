class Artist < ApplicationRecord
  belongs_to :member

  # バリデーションSTART------------------------------------------------------------------------------------------
  validates :name, length: { maximum: 100 }
  # バリデーションEND--------------------------------------------------------------------------------------------
end
