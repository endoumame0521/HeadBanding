class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "room_channel_#{params['room']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create! body: data['message'], member_id: current_member.id, room_id: params['room']
  end

  def remove(data)
    Message.find(data['message_id']).destroy!
  end
end

