class Members::RelationshipsController < ApplicationController
  def create
    current_member.follow(params[:member_id])
    redirect_to request.referer
  end

  def destroy
    current_member.unfollow(params[:member_id])
    redirect_to request.referer
  end

  def follower
    @members = Member.find(params[:member_id]).following_member
  end

  def followed
    @members = Member.find(params[:member_id]).follower_member
  end
end
