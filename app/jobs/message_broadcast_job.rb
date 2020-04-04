class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room_channel_#{message.room_id}", my_message: render_my_message(message), message: render_message(message), message_member_id: message.member_id
  end

  def render_my_message(message)
    ApplicationController.renderer.render partial: 'members/messages/my_message', locals: { message: message }
  end

  def render_message(message)
    ApplicationController.renderer.render partial: 'members/messages/message', locals: { message: message }
  end
end

