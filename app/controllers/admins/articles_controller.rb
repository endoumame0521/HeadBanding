class Admins::ArticlesController < Admins::ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]

  def index
    @search_params = article_search_params
    @articles = Article.search(@search_params)
    @articles = @articles.page(params[:page])
    @articles = @articles.includes([:member, :prefecture, part_articles: :part, genre_articles: :genre])
  end

  def show
    @part_articles = @article.part_articles.includes(:part)
    @genre_articles = @article.genre_articles.includes(:genre)
  end

  def update
    if @article.update(article_params)
      redirect_to request.referer, notice: "記事ステータスが更新されました"
    else
      redirect_to request.referer, alert: "記事ステータスの更新に失敗しました"
    end
  end

  def destroy
    if @article.destroy
      redirect_to admins_articles_path, notice: "記事が削除されました"
    else
      redirect_to admins_articles_path, alert: "記事の削除に失敗しました"
    end
  end

  private
  def article_params
    params.require(:article).permit(:status)
  end

  def article_search_params
    params.fetch(:search, {}).permit(
      :published_status, :category, :subject, :body, { prefecture_ids: [] }, { city_ids: [] },
      :day_of_the_week, :band_intention, :music_intention, :gender, :age_min, :age_max,
      :status, :band_theme, { part_ids: [] }, { genre_ids: [] })
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
