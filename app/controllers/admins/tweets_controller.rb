class Admins::TweetsController < Admins::ApplicationController
  def index
    @tweets = Tweet.all
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
      redirect_to request.referer, notice: "ツイートが削除されました"
    else
      redirect_to request.referer, alert: "ツイートの削除に失敗しました"
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:status)
  end
end
