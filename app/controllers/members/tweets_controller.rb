class Members::TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def create
    @tweet = current_member.tweets.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path, notice: "ツイートしました"
    else
      flash.now[:alert] = "#{@tweet.errors.count}件のエラーがあります"
      @tweets = Tweet.all
      render "index"
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.destroy
      redirect_to tweets_path, notice: "ツイートが削除されました"
    else
      redirect_to tweets_path, alert: "ツイートの削除に失敗しました"
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:body, :image)
  end
end
