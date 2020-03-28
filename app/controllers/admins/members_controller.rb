class Admins::MembersController < Admins::ApplicationController
  before_action :set_member, only: [:show, :update, :destroy]

  def index
    @search_params = member_search_params
    @members = Member.search(@search_params)
    @members = @members.page(params[:page])
    @members = @members.includes([part_members: :part])
  end

  def show
    @member_tweets = @member.tweets
    @member_articles = @member.articles.page(params[:page])
    @member_articles = @member_articles.includes([:prefecture, part_articles: :part, genre_articles: :genre])
  end

  def update
    if @member.update(member_params)
      redirect_to request.referer, notice: "会員ステータスを更新しました"
    else
      redirect_to request.referer, alert: "会員ステータスの更新に失敗しました"
    end
  end

  def destroy
    if @member.destroy
      redirect_to admins_members_path, notice: "会員が削除されました"
    else
      redirect_to admins_members_path, alert: "会員の削除に失敗しました"
    end
  end

  def follower
    @members = Member.find(params[:member_id]).following_member
    @members = @members.includes([part_members: :part])
  end

  def followed
    @members = Member.find(params[:member_id]).follower_member
    @members = @members.includes([part_members: :part])
  end

  def blocker
    @members = Member.find(params[:member_id]).blocking_member
    @members = @members.includes([part_members: :part])
  end

  def blocked
    @members = Member.find(params[:member_id]).blocker_member
    @members = @members.includes([part_members: :part])
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

  def set_member
    @member = Member.find(params[:id])
  end
end
