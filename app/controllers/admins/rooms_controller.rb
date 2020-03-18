class Admins::RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to admins_rooms_path, notice: "メッセージルームのステータスが更新されました"
    else
      redirect_to admins_rooms_path, alert: "メッセージルームのステータス更新に失敗しました"
    end
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @entries = @room.entries
  end

  private
  def room_params
    params.require(:room).permit(:status)
  end
end
