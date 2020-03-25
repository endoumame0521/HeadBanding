class Admins::TweetsController < Admins::ApplicationController
  def index
    @search_params = tweet_search_params
    @tweets = Tweet.search(@search_params)
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to request.referer, notice: "ツイートのステータスが更新されました"
    else
      redirect_to request.referer, alert: "ツイートのステータスが更新に失敗しました"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.destroy
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
end
