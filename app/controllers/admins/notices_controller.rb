class Admins::NoticesController < Admins::ApplicationController
  before_action :set_notice, only: [:show, :update, :destroy]

  def index
    @tweets = Notice.where.not(tweet_id: nil).includes([:member])
    @tweet_comments = Notice.where.not(tweet_comment_id: nil).includes([:member])
    @articles = Notice.where.not(article_id: nil).includes([:member])
  end

  def show
  end

  def update
    if @notice.update(notice_params)
      redirect_to request.referer, notice: "通報ステータスを更新しました"
    else
      redirect_to request.referer, alert: "通報ステータスの更新に失敗しました"
    end
  end

  def destroy
    if @notice.destroy
      redirect_to admins_notices_path, notice: "通報が削除されました"
    else
      redirect_to admins_notices_path, alert: "通報の削除に失敗しました"
    end
  end

  private
  def notice_params
    params.require(:notice).permit(:status)
  end

  def set_notice
    @notice = Notice.find(params[:id])
  end
end
