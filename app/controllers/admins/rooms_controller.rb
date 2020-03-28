class Admins::RoomsController < Admins::ApplicationController
  before_action :set_room, only: [:edit, :update, :destroy]

  def index
    @rooms = Room.all
    @rooms = @rooms.includes([:entries, :entry_members])
    @rooms = @rooms.page(params[:page])
  end

  def update
    if @room.update(room_params)
      redirect_to admins_rooms_path, notice: "メッセージルームのステータスが更新されました"
    else
      redirect_to admins_rooms_path, alert: "メッセージルームのステータス更新に失敗しました"
    end
  end

  def destroy
    if @room.destroy
      redirect_to admins_rooms_path, notice: "メッセージルームが削除されました"
    else
      redirect_to admins_rooms_path, alert: "メッセージルームの削除に失敗しました"
    end
  end

  private
  def room_params
    params.require(:room).permit(:status)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
