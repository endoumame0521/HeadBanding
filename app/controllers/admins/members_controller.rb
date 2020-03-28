class Admins::MembersController < Admins::ApplicationController
  def index
    @search_params = member_search_params
    @members = Member.search(@search_params)
    @members = @members.includes([part_members: :part])
    @members = @members.page(params[:page])
  end

  def show
    @member = Member.find(params[:id])
    @member_tweets = @member.tweets
    @member_articles = @member.articles.includes([:prefecture, part_articles: :part, genre_articles: :genre])
    @member_articles = @member_articles.page(params[:page])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to request.referer, notice: "会員ステータスを更新しました"
    else
      redirect_to request.referer, alert: "会員ステータスの更新に失敗しました"
    end
  end

  def destroy
    member = Member.find(params[:id])
    if member.destroy
      redirect_to admins_members_path, notice: "会員が削除されました"
    else
      redirect_to admins_members_path, alert: "会員の削除に失敗しました"
    end
  end

  def follower
    @members = Member.find(params[:member_id]).following_member
  end

  def followed
    @members = Member.find(params[:member_id]).follower_member
  end

  def blocker
    @members = Member.find(params[:member_id]).blocking_member
  end

  def blocked
    @members = Member.find(params[:member_id]).blocker_member
  end

  private
  def member_params
    params.require(:member).permit(:status)
  end

  def member_search_params
    params.fetch(:search, {}).permit(
      :name, :gender, :age_min, :age_max, :prefecture_id, { city_ids: [] },
      { part_ids: [] }, { genre_ids: [] }, { artists: [:name] }, :status)
  end
end
