class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "room_channel_#{params['room']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.new(body: data['message'], member_id: current_member.id, room_id: params['room'])
    message.save!
    message.create_announce_message!(current_member.id, params['room'])
  end

  def remove(data)
    Message.find(data['message_id']).destroy!
  end

  def read(data)
    Message.find(data['message_id']).update(read: true, read_at: DateTime.now)
  end
end

