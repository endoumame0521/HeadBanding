class Admins::TweetCommentsController < Admins::ApplicationController
  before_action :set_tweet_comment, only: [:update, :destroy]

  def update
    if @tweet_comment.update(tweet_comment_params)
      redirect_to request.referer, notice: "コメントのステータスが更新されました"
    else
      redirect_to request.referer, alert: "コメントのステータスの更新に失敗しました"
    end
  end

  def destroy
    if @tweet_comment.destroy
      redirect_to admins_tweets_path, notice: "コメントを削除しました"
    else
      redirect_to admins_tweets_path, alert: "コメントの削除に失敗しました"
    end
  end

  private
  def tweet_comment_params
    params.require(:tweet_comment).permit(:status)
  end

  def set_tweet_comment
    @tweet_comment = TweetComment.find_by(tweet_id: params[:tweet_id], id: params[:id])
  end
end
