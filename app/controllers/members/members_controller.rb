class Members::MembersController < Members::ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :article_favorites, :cancel, :withdraw]
  before_action :signed_in_member?, only: [:edit, :update, :article_favorites, :cancel, :withdraw]
  before_action :blocked_member?, only: [:show]

  def index
    @search_params = member_search_params
    @members = Member.search(@search_params).enable
    @members = @members.where.not(id: current_member.blocker_member)
    @members = @members.page(params[:page])
    @members = @members.includes([part_members: :part])
  end

  def show
    @member_tweets = @member.tweets.enable

    @member_articles = @member.articles.enable.open
    @member_articles = @member_articles.page(params[:page])
    @member_articles = @member_articles.includes([:prefecture, part_articles: :part, genre_articles: :genre])

    # メッセージルーム関係START----------------------------------------------------------
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
    # メッセージルーム関係END-----------------------------------------------------------
  end

  def edit
  end

  def update
    if @member.update(member_params)
      redirect_to @member, notice: "会員情報を更新しました"
    else
      flash.now[:alert] = "#{@member.errors.count}件のエラーがあります"
      render "edit"
    end
  end

  def article_favorites
    @favorited_articles = current_member.favorited_articles.enable.open
    @favorited_articles = @favorited_articles.where.not(member_id: current_member.blocker_member)
    @favorited_articles = @favorited_articles.page(params[:page])
    @favorited_articles = @favorited_articles.includes([:member, :prefecture, part_articles: :part, genre_articles: :genre])
  end

  def cancel
  end

  def withdraw
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

  def member_search_params
    params.fetch(:search, {}).permit(
      :name, :gender, :age_min, :age_max, :prefecture_id, { city_ids: [] },
      { part_ids: [] }, { genre_ids: [] }, { artists: [:name] }, :status)
  end

  def set_member
    if params[:member_id].nil?
      @member = Member.find(params[:id])
    else
      @member = Member.find(params[:member_id])
    end
  end

  def signed_in_member? #ログインメンバー以外のアクセス、編集を禁止
    unless current_member.id == @member.id
      redirect_to top_path, alert: "アクセスが拒否されました"
    end
  end

  def blocked_member? #会員が退会済、またはブロックされていればアクセスできない
    if @member.blocking?(current_member) || @member.disable?
      redirect_to top_path, alert: "アクセスできません"
    end
  end
end
