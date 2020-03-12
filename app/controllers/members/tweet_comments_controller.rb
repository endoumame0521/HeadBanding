class Members::TweetCommentsController < ApplicationController
  def create
    @tweet_comment = current_member.tweet_comments.new(tweet_comment_params)
    @tweet_comment.tweet_id = params[:tweet_id]
    if @tweet_comment.save
      redirect_to tweet_path(@tweet_comment.tweet), notice: "コメントしました"
    else
      flash.now[:alert] = "#{@tweet_comment.errors.count}件のエラーがあります"
      @tweet = Tweet.find(params[:tweet_id])
      render "tweets/show"
    end
  end

  def destroy
    tweet_comment = TweetComment.find_by(tweet_id: params[:tweet_id], id: params[:id])
    if tweet_comment.destroy
      redirect_to tweet_path(tweet_comment.tweet), notice: "コメントを削除しました"
    else
      redirect_to tweet_path(tweet_comment.tweet), alert: "コメントの削除に失敗しました"
    end
  end

  private
  def tweet_comment_params
    params.require(:tweet_comment).permit(:body, :image)
  end
end
