class Members::AnnouncesController < ApplicationController
  def index
    Announce.where(checked: false).update_all(checked: true) #未読の通知を既読にする
    @announces = current_member.reciever.page(params[:page])
    @announces = @announces.includes([:article, :announcer, :reciever, tweet: :member, tweet_comment: :tweet, message: :room])
  end
end
