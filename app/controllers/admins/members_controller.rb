class Admins::MembersController < Admins::ApplicationController
  def index
    @search_params = member_search_params
    @members = Member.search(@search_params)
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to request.referer, notice: "会員情報を更新しました"
    else
      flas.now[:alert] = "#{@member.errors.count}件のエラーがあります"
      render "edit"
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
    params.require(:member).permit(
      :name, :gender, :birthday, :address_prefecture, :address_city, :introduction,
      :sound, :profile_image, :email, :status, { part_ids: [] }, { genre_ids: [] },
      artists_attributes: [:id, :name])
  end

  def member_search_params
    params.fetch(:search, {}).permit(
      :name, :gender, :age_min, :age_max, { address_prefecture_ids: [] }, { address_city_ids: [] },
      { part_ids: [] }, { genre_ids: [] }, { artists: [:name] }, :status)
  end
end
