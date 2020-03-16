class Members::RoomsController < ApplicationController
  def index
  end

  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, member_id: current_member.id)
    @entry2 = Entry.create(params.require(:entry).permit(:member_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])

    if Entry.where(member_id: current_member.id, room_id: @room.id).present?
      @messages = @room.messages
      @entries = @room.entries
    else
      redirect_to request.referer
    end
  end
end
