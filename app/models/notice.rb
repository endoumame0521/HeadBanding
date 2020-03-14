class Notice < ApplicationRecord
  belongs_to :member
  belongs_to :tweet, optional: true
  belongs_to :tweet_comment, optional: true
  belongs_to :article, optional: true
  enum status: { open: 0, close: 1, missreporting: 2 }
end
