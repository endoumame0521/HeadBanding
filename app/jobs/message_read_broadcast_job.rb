class MessageReadBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room_channel_#{message.room_id}",
                                  message: render_json(message)
  end

  private
  def render_json(message)
    ApplicationController.renderer.render(json: message)
  end
end
