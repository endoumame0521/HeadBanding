class Members::MembersController < ApplicationController
  before_action :signed_in_member, only: [:edit, :update]

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])

    if @member.blocking?(current_member)
      redirect_to request.referrer, alert: "アクセスが拒否されました"
    end

    @current_member_entry = Entry.where(member_id: current_member.id)
    @member_entry = Entry.where(member_id: @member.id)
    if current_member.id != @member.id
      @current_member_entry.each do |cme|
        @member_entry.each do |me|
          if cme.room_id == me.room_id
            @is_room = true
            @room_id = cme.room_id
          end
        end
      end

      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to @member, notice: "会員情報を更新しました"
    else
      flash.now[:alert] = "#{@member.errors.count}件のエラーがあります"
      render "edit"
    end
  end

  def article_favorites
    @favorited_articles = current_member.favorited_articles
  end

  def cancel
    @member = Member.find(params[:member_id])
  end

  def withdraw
    @member = Member.find(params[:member_id])
    @member.update(member_params)
    if @member.disable?
      reset_session
      redirect_to top_path, notice: "退会しました"
    else
      redirect_to member_path(@member)
    end
  end

  private
  def member_params
    params.require(:member).permit(
      :name, :gender, :birthday, :address_prefecture, :address_city, :introduction,
      :sound, :profile_image, :email, :status, { part_ids: [] }, { genre_ids: [] },
      artists_attributes: [:id, :name])
  end

  def signed_in_member #ログインメンバー以外のアクセス、編集を禁止
    unless current_member.id == params[:id].to_i
      redirect_to top_path, alert: "アクセスが拒否されました"
    end
  end
end
