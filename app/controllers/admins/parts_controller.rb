class Admins::PartsController < Admins::ApplicationController
  def index
    @parts = Part.all
  end

  def create
    @part = Part.new(part_params)
    if @part.save
      redirect_to admins_parts_path, notice: "パートを追加しました"
    else
      flash.now[:alert] = "#{@part.errors.count}件のエラーがあります"
      @parts = Part.all
      render "index"
    end
  end

  def edit
    @part = Part.find(params[:id])
  end

  def update
    @part = Part.find(params[:id])
    if @part.update(part_params)
      redirect_to admins_parts_path, notice: "パート情報を更新しました"
    else
      flash.now[:alert] = "#{@part.errors.count}件のエラーがあります"
      render "edit"
    end
  end

  def destroy
    part = Part.find(params[:id])
    if part.destroy
      redirect_to admins_parts_path, notice: "パートが削除されました"
    else
      redirect_to admins_parts_path, alert: "パートの削除に失敗しました"
    end
  end

  private
  def part_params
    params.require(:part).permit(:name, :status)
  end
end
