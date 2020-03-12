class Members::ArticleFavoritesController < ApplicationController
  def create
    article_favorite = current_member.article_favorites.new
    article_favorite.article_id = params[:article_id]
    if article_favorite.save
      redirect_to request.referrer, notice: "記事をお気に入りに追加しました"
    else
      redirect_to request.referrer, alert: "記事のお気に入り追加に失敗しました"
    end
  end

  def destroy
    article_favorite = current_member.article_favorites.find_by(article_id: params[:article_id])
    if article_favorite.destroy
      redirect_to request.referrer, notice: "記事をお気に入りから外しました"
    else
      redirect_to request.referrer, alert: "記事のお気に入り解除に失敗しました"
    end
  end
end
