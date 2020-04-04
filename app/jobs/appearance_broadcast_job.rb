class AppearanceBroadcastJob < ApplicationJob
  queue_as :default

  def perform(member)
    # Do something later
    ActionCable.server.broadcast "appearance_member",
                                  member: render_json(member),
                                  online: render_online(member),
                                  offline: render_offline(member)
  end

  private
  def render_json(member)
    ApplicationController.renderer.render(json: member)
  end

  def render_online(member)
    ApplicationController.renderer.render partial: "members/member_histries/online", locals: { member: member }
  end

  def render_offline(member)
    ApplicationController.renderer.render partial: "members/member_histries/offline", locals: { member: member }
  end
end
