class Members::TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :destroy]
  before_action :signed_in_member?, only: [:destroy]
  before_action :blocked_member?, only: [:show]

  def index
    @tweets = Tweet.all
  end

  def create
    @tweet = current_member.tweets.new(tweet_params)
    if @tweet.save
      flash.now[:notice] = "ツイートしました"
    else
      flash.now[:alert] = "#{@tweet.errors.count}件のエラーがあります"
      @tweets = Tweet.all
      render "index"
    end
  end

  def show
  end

  def destroy
    if @tweet.destroy
      flash.now[:notice] = "ツイートが削除されました"
    else
      flash.now[:alert] = "ツイートの削除に失敗しました"
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:body, :image)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def signed_in_member? #ログインメンバー以外のアクセス、編集を禁止
    unless current_member.id == @tweet.member_id
      redirect_to top_path, alert: "アクセスが拒否されました"
    end
  end

  def blocked_member? # 会員が退会済、またはブロックされていればアクセスできない
    if @tweet.member.blocking?(current_member) || @tweet.member.disable?
      redirect_to top_path, alert: "アクセスできません"
    end
  end
end
