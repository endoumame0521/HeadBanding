class AddColumnsToNotices < ActiveRecord::Migration[5.2]
  def change
    add_reference :notices, :tweet
    add_reference :notices, :tweet_comment
    add_reference :notices, :article
  end
end
