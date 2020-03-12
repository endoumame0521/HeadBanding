class Members::TweetFavoritesController < ApplicationController
  def create
    tweet_favorite = current_member.tweet_favorites.new
    tweet_favorite.tweet_id = params[:tweet_id]
    if tweet_favorite.save
      redirect_to request.referrer, notice: "いいねしました"
    else
      redirect_to request.referrer, alert: "いいねに失敗しました"
    end
  end

  def destroy
    tweet_favorite = current_member.tweet_favorites.find_by(tweet_id: params[:tweet_id])
    if tweet_favorite.destroy
      redirect_to request.referrer, notice: "いいねを取り消しました"
    else
      redirect_to request.referrer, alert: "いいねの取り消しに失敗しました"
    end
  end
end
