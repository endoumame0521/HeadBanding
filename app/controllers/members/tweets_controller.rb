class Members::TweetsController < Members::ApplicationController
  skip_before_action :authenticate_member!, only: [:index, :show]
  before_action :set_tweet, only: [:show, :destroy]
  before_action :signed_in_member?, only: [:destroy]
  before_action :blocked_member?, only: [:show]

  def index
    @search_params = tweet_search_params
    @tweets = Tweet.search(@search_params).status_is("enable")
    @tweets = @tweets.where(member_id: Member.where(status: "enable"))
    @tweets = @tweets.includes([:member, member: :blocking_member])
    @tweets = @tweets.page(params[:page])
  end

  def create
    @tweet = current_member.tweets.new(tweet_params)
    if @tweet.save
      flash.now[:notice] = "ツイートしました"
    else
      flash.now[:alert] = "#{@tweet.errors.count}件のエラーがあります"
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

  def tweet_search_params
    params.fetch(:search, {}).permit(:body, :status)
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
