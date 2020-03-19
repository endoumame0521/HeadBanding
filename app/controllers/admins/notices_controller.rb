class Admins::NoticesController < Admins::ApplicationController
  def index
    @tweets = Notice.where.not(tweet_id: nil)
    @tweet_comments = Notice.where.not(tweet_comment_id: nil)
    @articles = Notice.where.not(article_id: nil)
  end

  def show
    @notice = Notice.find(params[:id])
  end

  def update
    @notice = Notice.find(params[:id])
    if @notice.update(notice_params)
      redirect_to request.referer, notice: "通報ステータスを更新しました"
    else
      redirect_to request.referer, alert: "通報ステータスの更新に失敗しました"
    end
  end

  private
  def notice_params
    params.require(:notice).permit(:status)
  end
end
