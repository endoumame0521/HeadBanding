class Members::BlocksController < ApplicationController
  def create
    current_member.block(params[:member_id])
    if current_member.following?(Member.find(params[:member_id]))
      current_member.unfollow(params[:member_id])
    end
    redirect_to request.referer
  end

  def destroy
    current_member.unblock(params[:member_id])
    redirect_to request.referer
  end

  def blocker
    @members = Member.find(params[:member_id]).blocking_member
  end
end
