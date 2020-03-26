class Members::NoticesController < Members::ApplicationController
  def new
    @notice = Notice.new

    if params[:tweet_id].present?
      @tweet = Tweet.find(params[:tweet_id])
      @tweet_flag = true
      @show_path = tweet_path(@tweet.id)
    elsif params[:tweet_comment_id].present?
      @tweet_flag = false
      @tweet = TweetComment.find(params[:tweet_comment_id])
      @show_path = tweet_tweet_comment_path(@tweet.tweet_id, @tweet.id)
    elsif params[:article_id].present?
      @article = Article.find(params[:article_id])
    end
  end

  def create
    @notice = current_member.notices.new(notice_params)

    if @notice.save
      redirect_to top_path, notice: "通報を投稿しました"
    else
      redirect_to request.referer, alert: "通報内容を入力してください"
    end
  end

  private
  def notice_params
    params.require(:notice).permit(:body, :tweet_id, :tweet_comment_id, :article_id)
  end
end
