class Admins::GenresController < Admins::ApplicationController
  before_action :set_genre, only: [:edit, :update, :destroy]

  def index
    @genres = Genre.all
    @genres = @genres.page(params[:page])
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admins_genres_path, notice: "ジャンルを追加しました"
    else
      flash.now[:alert] = "#{@genre.errors.count}件のエラーがあります"
      index
      render "index"
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to admins_genres_path, notice: "ジャンル情報を更新しました"
    else
      flash.now[:alert] = "#{@genre.errors.count}件のエラーがあります"
      render "edit"
    end
  end

  def destroy
    if @genre.destroy
      redirect_to admins_genres_path, notice: "ジャンルが削除されました"
    else
      redirect_to admins_genres_path, alert: "ジャンルの削除に失敗しました"
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name, :status)
  end

  def set_genre
    @genre = Genre.find(params[:id])
  end
end
