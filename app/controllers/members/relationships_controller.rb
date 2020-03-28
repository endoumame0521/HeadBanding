class Members::RelationshipsController < Members::ApplicationController
  before_action :set_member
  before_action :blocked_member?, only: [:create, :destroy, :follower, :followed]

  def create
    current_member.follow(params[:member_id])
    flash.now[:notice] = "#{@member.name}さんをフォローしました"
  end

  def destroy
    current_member.unfollow(params[:member_id])
    flash.now[:notice] = "#{@member.name}さんのフォローを外しました"
  end

  def follower
    @members = @member.following_member
    @members = @members.where.not(id: current_member.blocker_member)
    @members = @members.page(params[:page])
    @members = @members.includes([part_members: :part])
  end

  def followed
    @members = @member.follower_member
    @members = @members.where.not(id: current_member.blocker_member)
    @members = @members.page(params[:page])
    @members = @members.includes([part_members: :part])
  end

  private
  def set_member
    @member = Member.find(params[:member_id])
  end

  def blocked_member? # 会員が退会済、またはブロックされていればフォロー、アンフォローできない。アクセスもできない。
    if @member.blocking?(current_member) || @member.disable?
      redirect_to top_path, alert: "アクセスできません"
    end
  end
end
