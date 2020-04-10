class Members::TweetCommentFavoritesController < Members::ApplicationController
  before_action :set_tweet_comment

  def create
    tweet_comment_favorite = current_member.tweet_comment_favorites.new
    tweet_comment_favorite.tweet_comment_id = params[:tweet_comment_id]
    if tweet_comment_favorite.save
      flash.now[:notice] = "コメントをいいねしました"
      # ツイートコメントのいいね通知を作成
      TweetComment.find(params[:tweet_comment_id]).create_announce_tweet_comment_favorite!(current_member)
    else
      flash.now[:alert] = "コメントのいいねに失敗しました"
    end
  end

  def destroy
    tweet_comment_favorite = current_member.tweet_comment_favorites.find_by(tweet_comment_id: params[:tweet_comment_id])
    if tweet_comment_favorite.destroy
      flash.now[:notice] = "コメントのいいねを取り消しました"
    else
      flash.now[:alert] = "コメントのいいね取り消しに失敗しました"
    end
  end

  private
  def set_tweet_comment
    @tweet = TweetComment.find(params[:tweet_comment_id])
  end
end
