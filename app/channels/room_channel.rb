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
    message = Message.find(data['message_id'])
    room_id = message.room_id
    message.destroy!
    ActionCable.server.broadcast "room_channel_#{room_id}", message_id: data['message_id']
  end
end

