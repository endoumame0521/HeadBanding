class Members::TweetCommentsController < ApplicationController
  before_action :set_tweet_comment, only: [:destroy]
  before_action :signed_in_member?, only: [:destroy]

  def create
    @tweet_comment = current_member.tweet_comments.new(tweet_comment_params)
    @tweet_comment.tweet_id = params[:tweet_id]
    if @tweet_comment.save
      flash.now[:notice] = "コメントしました"
    else
      flash.now[:alert] = "#{@tweet_comment.errors.count}件のエラーがあります"
      @tweet = Tweet.find(params[:tweet_id])
      render "tweets/show"
    end
  end

  def destroy
    if @tweet_comment.destroy
      flash.now[:notice] = "コメントを削除しました"
    else
      flash.now[:alert] = "コメントの削除に失敗しました"
    end
  end

  private
  def tweet_comment_params
    params.require(:tweet_comment).permit(:body, :image)
  end

  def set_tweet_comment
    @tweet_comment = TweetComment.find_by(tweet_id: params[:tweet_id], id: params[:id])
  end

  def signed_in_member? #ログインメンバー以外のアクセス、編集を禁止
    @tweet_comment = TweetComment.find_by(tweet_id: params[:tweet_id], id: params[:id])
    unless current_member.id == @tweet_comment.member_id
      redirect_to top_path, alert: "アクセスが拒否されました"
    end
  end
end
