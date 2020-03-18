class Members::BlocksController < ApplicationController
  before_action :set_member
  before_action :withdrawed_member?, only: [:create, :destroy]

  def create
    current_member.block(params[:member_id])
    if current_member.following?(@member)
      current_member.unfollow(params[:member_id])
    end
   flash.now[:notice] = "#{@member.name}さんをブロックしました"
  end

  def destroy
    current_member.unblock(params[:member_id])
    flash.now[:notice] = "#{@member.name}さんのブロックを解除しました"
  end

  def blocker
    @members = @member.blocking_member
  end

  private
  def set_member
    @member = Member.find(params[:member_id])
  end

  def withdrawed_member? # 会員が退会済であればブロック、アンブロックできない
    if @member.disable?
      redirect_to top_path, alert: "アクセスできません"
    end
  end
end
