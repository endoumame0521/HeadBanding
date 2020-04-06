class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room_channel_#{message.room_id}",
                                  my_message: render_my_message(message),
                                  other_message: render_other_message(message),
                                  message: render_json(message)
  end

  private
  def render_my_message(message)
    ApplicationController.renderer.render partial: 'members/messages/my_message', locals: { message: message }
  end

  def render_other_message(message)
    ApplicationController.renderer.render partial: 'members/messages/message', locals: { message: message }
  end

  def render_json(message)
    ApplicationController.renderer.render(json: message)
  end
end

