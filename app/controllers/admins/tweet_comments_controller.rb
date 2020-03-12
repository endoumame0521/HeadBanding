class Admins::TweetCommentsController < ApplicationController
  def update
    @tweet_comment = TweetComment.find_by(tweet_id: params[:tweet_id], id: params[:id])
    if @tweet_comment.update(tweet_comment_params)
      redirect_to admins_tweet_path(@tweet_comment.tweet), notice: "コメントのステータスが更新されました"
    else
      redirect_to admins_tweet_path(@tweet_comment.tweet), alert: "コメントのステータスの更新に失敗しました"
    end
  end

  def destroy
    tweet_comment = TweetComment.find_by(tweet_id: params[:tweet_id], id: params[:id])
    if tweet_comment.destroy
      redirect_to admins_tweet_path(tweet_comment.tweet), notice: "コメントを削除しました"
    else
      redirect_to admins_tweet_path(tweet_comment.tweet), alert: "コメントの削除に失敗しました"
    end
  end

  private
  def tweet_comment_params
    params.require(:tweet_comment).permit(:status)
  end
end
