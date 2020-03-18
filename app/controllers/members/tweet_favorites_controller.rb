class Members::TweetFavoritesController < ApplicationController
  before_action :set_tweet

  def create
    tweet_favorite = current_member.tweet_favorites.new
    tweet_favorite.tweet_id = params[:tweet_id]
    if tweet_favorite.save
      flash.now[:notice] = "ツイートをいいねしました"
    else
      flash.now[:alert] = "ツイートのいいねに失敗しました"
    end
  end

  def destroy
    tweet_favorite = current_member.tweet_favorites.find_by(tweet_id: params[:tweet_id])
    if tweet_favorite.destroy
      flash.now[:notice] = "ツイートのいいねを取り消しました"
    else
      flash.now[:alert] = "ツイートのいいね取り消しに失敗しました"
    end
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
