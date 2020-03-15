class Block < ApplicationRecord
  belongs_to :blocker, class_name: "Member"
  belongs_to :blocked, class_name: "Member"
end
