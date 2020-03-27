class Admins::GenresController < Admins::ApplicationController
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
      @genres = Genre.all
      render "index"
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admins_genres_path, notice: "ジャンル情報を更新しました"
    else
      flash.now[:alert] = "#{@genre.errors.count}件のエラーがあります"
      render "edit"
    end
  end

  def destroy
    genre = Genre.find(params[:id])
    if genre.destroy
      redirect_to admins_genres_path, notice: "ジャンルが削除されました"
    else
      redirect_to admins_genres_path, alert: "ジャンルの削除に失敗しました"
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name, :status)
  end
end
