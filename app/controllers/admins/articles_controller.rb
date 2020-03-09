class Admins::ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to admins_articles_path, notice: "記事ステータスが更新されました"
    else
      @article = Article.all
      flash.now[:alert] = "#{@article.errors.count}件のエラーが有ります"
      render "show"
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

end
