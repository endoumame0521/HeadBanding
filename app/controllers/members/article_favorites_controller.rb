class Members::ArticleFavoritesController < Members::ApplicationController
  before_action :set_article

  def create
    article_favorite = current_member.article_favorites.new
    article_favorite.article_id = params[:article_id]
    if article_favorite.save
      flash.now[:notice] = "記事をお気に入りに追加しました"
      # 記事のお気に入り追加通知を作成
      Article.find(params[:article_id]).create_announce_article_favorite!(current_member)
    else
      flash.now[:alert] = "記事のお気に入り追加に失敗しました"
    end
  end

  def destroy
    article_favorite = current_member.article_favorites.find_by(article_id: params[:article_id])
    if article_favorite.destroy
      flash.now[:notice] = "記事をお気に入りから外しました"
    else
      flash.now[:alert] = "記事のお気に入り解除に失敗しました"
    end
  end

  private
  def set_article
    @article = Article.find(params[:article_id])
  end
end