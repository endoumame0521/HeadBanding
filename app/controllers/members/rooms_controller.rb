class Members::RoomsController < Members::ApplicationController
  def index
    @entry_rooms = current_member.entry_rooms.enable
    @entry_rooms = @entry_rooms.page(params[:page])
    # @entry_rooms = @entry_rooms.includes([:entries, :entry_members])
  end

  def create
    @member = Member.find(room_params[:member_id])

    current_member_entry = Entry.where(member_id: current_member.id)
    member_entry = Entry.where(member_id: @member.id)
    current_member_entry.each do |cme|
      member_entry.each do |me|
        @is_room = true if cme.room_id == me.room_id
      end
    end

    # 会員が退会済、またはブロックされていればメッセージルームを作成できない
    if @member.blocking?(current_member) || @member.disable?
      redirect_to top_path, alert: "アクセスできません"
    else
      unless @is_room #お互いのチャットルームが存在しない時のみルーム作成
        @room = Room.create
        @entry1 = Entry.create(room_id: @room.id, member_id: current_member.id)
        @entry2 = Entry.create(room_params.merge(room_id: @room.id))
        redirect_to room_path(@room.id)
      end
    end
  end

  def show
    @room = Room.find(params[:id])

    # 自分のメッセージルームでない場合はアクセスできない
    if Entry.where(member_id: current_member.id, room_id: @room.id).present?
      @messages = @room.messages.where.not(member_id: current_member.blocker_member)
      @messages = @messages.includes([:member])
      @messages = @messages.page(params[:page])

      @entries = @room.entries.includes([:member])
      @entries.each do |entry|
        if entry.member.id != current_member.id
          @member = Member.find(entry.member_id)
        end
      end

      # 会員が退会済、またはブロックされていればメッセージルームにアクセスできない
      if @member.blocking?(current_member) || @member.disable?
        redirect_to top_path, alert: "アクセスできません"
      end
    else
      redirect_to top_path, alert: "アクセスできません"
    end
  end

  def all_message_read
    # アクセスした部屋の相手のメッセージに未読がある場合、全てに既読をつける（readカラムをtrueに更新する）
    messages = Message.where(read: false, room_id: params[:room_id], member_id: params[:other_member_id])
    if messages.present?
      messages.update_all(read: true)
      # 相手のチャットルーム画面のメッセージに{既読}を表示させる為にbroadcastする
      ActionCable.server.broadcast "room_channel_#{params[:room_id]}",
                                    other_member_id: params[:other_member_id].to_i,
                                    all_read_flag: true
    end
  end

  private
  def room_params
    params.require(:entry).permit(:member_id, :room_id)
  end
end
