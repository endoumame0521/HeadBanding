class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room_channel_#{message.room_id}", message: message, message_member_id: message.member_id
  end
end