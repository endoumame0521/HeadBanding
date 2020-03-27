class Members::ArticlesController < Members::ApplicationController
  skip_before_action :authenticate_member!, only: [:top, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_member?, only: [:edit, :update, :destroy]
  before_action :blocked_member?, only: [:show]

  def top
    @search_params = article_search_params
    @articles = Article.search(@search_params).status_is("enable").published_status_is("open")
    @articles = @articles.where(member_id: Member.where(status: "enable"))
    @articles = @articles.includes([:member, :prefecture, part_articles: :part, genre_articles: :genre, member: :blocking_member])
    @articles = @articles.page(params[:page])
  end

  def index
    top
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_member.articles.new(article_params)
    if @article.save
      redirect_to @article, notice: "記事が投稿されました"
    else
      flash.now[:alert] = "#{@article.errors.count}件のエラーが有ります"
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "記事が更新されました"
    else
      flash.now[:alert] = "#{@article.errors.count}件のエラーがあります"
      render "edit"
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path, notice: "記事が削除されました"
    else
      redirect_to articles_path, alert: "記事の削除に失敗しました"
    end
  end

  private
  def article_params
    params.require(:article).permit(
      :published_status, :category, :subject, :body, :prefecture_id, { city_ids: [] },
      :day_of_the_week, :band_intention, :music_intention, :gender, :age_min, :age_max,
      :sound, :band_theme, { part_ids: [] }, { genre_ids: [] })
  end

  def article_search_params
    params.fetch(:search, {}).permit(
      :published_status, :category, :subject, :body, :prefecture_id, { city_ids: [] },
      :day_of_the_week, :band_intention, :music_intention, :gender, :age_min, :age_max,
      :status, :band_theme, { part_ids: [] }, { genre_ids: [] })
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def signed_in_member? #ログインメンバー以外のアクセス、編集を禁止
    unless current_member.id == @article.member_id
      redirect_to top_path, alert: "アクセスが拒否されました"
    end
  end

  def blocked_member? # 会員が退会済、またはブロックされていればアクセスできない
    if @article.member.blocking?(current_member) || @article.member.disable?
      redirect_to top_path, alert: "アクセスできません"
    end
  end
end
