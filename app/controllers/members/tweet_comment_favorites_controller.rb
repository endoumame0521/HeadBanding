class Members::TweetCommentFavoritesController < ApplicationController
  def create
    tweet_comment_favorite = current_member.tweet_comment_favorites.new
    tweet_comment_favorite.tweet_comment_id = params[:tweet_comment_id]
    if tweet_comment_favorite.save
      redirect_to request.referer, notice: "いいねしました"
    else
      redirect_to request.referer, alert: "いいねに失敗しました"
    end
  end

  def destroy
    tweet_comment_favorite = current_member.tweet_comment_favorites.find_by(tweet_comment_id: params[:tweet_comment_id])
    if tweet_comment_favorite.destroy
      redirect_to request.referrer, notice: "いいねを取り消しました"
    else
      redirect_to request.referrer, alert: "いいねの取り消しに失敗しました"
    end
  end
end
