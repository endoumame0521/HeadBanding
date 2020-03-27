class Admins::ArticlesController < Admins::ApplicationController
  def index
    @search_params = article_search_params
    @articles = Article.search(@search_params)
    @articles = @articles.includes([:member, :prefecture, part_articles: :part, genre_articles: :genre])
    @articles = @articles.page(params[:page])
  end

  def show
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to request.referer, notice: "記事ステータスが更新されました"
    else
      redirect_to request.referer, alert: "記事ステータスの更新に失敗しました"
    end
  end

  def destroy
    article = Article.find(params[:id])
    if article.destroy
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
end
