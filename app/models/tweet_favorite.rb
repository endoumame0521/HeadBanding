class TweetFavorite < ApplicationRecord
  belongs_to :member
  belongs_to :tweet
end
