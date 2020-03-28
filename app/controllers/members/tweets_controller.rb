class Members::TweetsController < Members::ApplicationController
  skip_before_action :authenticate_member!, only: [:index, :show]
  before_action :set_tweet, only: [:show, :destroy]
  before_action :signed_in_member?, only: [:destroy]
  before_action :blocked_member?, only: [:show]

  def index
    @search_params = tweet_search_params
    @tweets = Tweet.search(@search_params).enable
    @tweets = @tweets.where(member_id: Member.enable)
    @tweets = @tweets.where.not(member_id: current_member.blocker_member)
    @tweets = @tweets.page(params[:page])
    @tweets = @tweets.includes([:member])
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
    @tweet_comments = @tweet.tweet_comments.enable
    @tweet_comments = @tweet_comments.where(member_id: Member.enable)
    @tweet_comments = @tweet_comments.where.not(member_id: current_member.blocker_member)
    @tweet_comments = @tweet_comments.page(params[:page])
    @tweet_comments = @tweet_comments.includes([:member])
  end

  def destroy
    if @tweet.destroy
      # 削除する前のURLがshowページならindexページへリダイレクトさせる
      if request.referer.split('/')[4].to_i == @tweet.id
        redirect_to tweets_path, notice: "ツイートが削除されました"
      else
        flash.now[:notice] = "ツイートが削除されました"
      end
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
    if @tweet.disable?
      redirect_to top_path, alert: "無効なツイートです"
    end
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
