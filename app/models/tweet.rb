class Tweet < ApplicationRecord
  belongs_to :member
  has_many :tweet_comments
  has_many :tweet_favorites
end
