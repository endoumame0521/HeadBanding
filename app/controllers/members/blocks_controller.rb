class Members::BlocksController < Members::ApplicationController
  before_action :set_member
  before_action :signed_in_member?, only: [:blocker]
  before_action :withdrawed_member?, only: [:create, :destroy, :blocker]

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
    @members = @members.where.not(id: current_member.blocker_member)
    @members = @members.page(params[:page])
    @members = @members.includes([part_members: :part])
  end

  private
  def set_member
    @member = Member.find(params[:member_id])
  end

  def signed_in_member? #ログインメンバー以外のアクセス、編集を禁止
    unless current_member.id == @member.id
      redirect_to top_path, alert: "アクセスが拒否されました"
    end
  end

  def withdrawed_member? # 会員が退会済であればブロック、アンブロックできない。アクセスもできない。
    if @member.disable?
      redirect_to top_path, alert: "アクセスできません"
    end
  end
end
