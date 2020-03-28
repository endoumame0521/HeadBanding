class TweetCommentFavorite < ApplicationRecord
  belongs_to :member
  belongs_to :tweet_comment
end
