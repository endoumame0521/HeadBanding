class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    member = Member.where(id: current_member.id).first
    return unless member
    member.update_columns(online: true, online_at: DateTime.now)
    stream_from "appearance_member"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    member = Member.where(id: current_member.id).first
    return unless member
    member.update_columns(online: false, online_at: DateTime.now)
    stream_from "appearance_member"
  end
end
