class Admins::TweetsController < Admins::ApplicationController
  before_action :set_tweet, only: [:show, :update, :destroy]

  def index
    @search_params = tweet_search_params
    @tweets = Tweet.search(@search_params)
    @tweets = @tweets.includes([:member])
    @tweets = @tweets.page(params[:page])
  end

  def show
    @tweet_comments = @tweet.tweet_comments
    @tweet_comments = @tweet_comments.page(params[:page])
    @tweet_comments = @tweet_comments.includes([:member])
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to request.referer, notice: "ツイートのステータスが更新されました"
    else
      redirect_to request.referer, alert: "ツイートのステータスが更新に失敗しました"
    end
  end

  def destroy
    if @tweet.destroy
      redirect_to admins_tweets_path, notice: "ツイートが削除されました"
    else
      redirect_to admins_tweets_path, alert: "ツイートの削除に失敗しました"
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:status)
  end

  def tweet_search_params
    params.fetch(:search, {}).permit(:body, :status)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
