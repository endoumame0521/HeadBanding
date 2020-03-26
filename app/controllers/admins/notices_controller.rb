class Admins::NoticesController < Admins::ApplicationController
  def index
    @tweets = Notice.where.not(tweet_id: nil).includes([:member])
    @tweet_comments = Notice.where.not(tweet_comment_id: nil).includes([:member])
    @articles = Notice.where.not(article_id: nil).includes([:member])
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

  def destroy
    notice = Notice.find(params[:id])
    if notice.destroy
      redirect_to admins_notices_path, notice: "通報が削除されました"
    else
      redirect_to admins_notices_path, alert: "通報の削除に失敗しました"
    end
  end

  private
  def notice_params
    params.require(:notice).permit(:status)
  end
end
