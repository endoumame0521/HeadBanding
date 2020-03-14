class Access < ApplicationRecord
  belongs_to :visitor, class_name: "Member"
  belongs_to :visited, class_name: "Member"
end