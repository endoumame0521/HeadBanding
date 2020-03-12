class Members::ArticlesController < ApplicationController
  def top
    @articles = Article.all
  end

  def index
    @articles = Article.all
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
      @article = Article.new
      render "new"
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: "記事が更新されました"
    else
      flash.now[:alert] = "#{@article.errors.count}件のエラーがあります"
      render "edit"
    end
  end

  def destroy
    article = Article.find(params[:id])
    if article.destroy
      redirect_to article, notice: "記事が削除されました"
    else
      redirect_to article, alert: "記事の削除に失敗しました"
    end
  end

  private
  def article_params
    params.require(:article).permit(
      :published_status, :category, :subject, :body, :prefecture_id, { city_ids: [] },
      :day_of_the_week, :band_intention, :music_intention, :gender, :age_min, :age_max,
      :sound, :band_theme, { part_ids: [] }, { genre_ids: [] })
  end
end
