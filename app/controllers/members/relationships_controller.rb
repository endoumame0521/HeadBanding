class Members::RelationshipsController < Members::ApplicationController
  before_action :set_member
  before_action :blocked_member?, only: [:create, :destroy]

  def create
    current_member.follow(params[:member_id])
    flash.now[:notice] = "#{@member.name}さんをフォローしました"
  end

  def destroy
    current_member.unfollow(params[:member_id])
    flash.now[:notice] = "#{@member.name}さんのフォローを外しました"
  end

  def follower
    @members = @member.following_member.includes([:blocking_member, part_members: :part])
    @members = @members.page(params[:page])
  end

  def followed
    @members = @member.follower_member.includes([:blocking_member, part_members: :part])
    @members = @members.page(params[:page])
  end

  private
  def set_member
    @member = Member.find(params[:member_id])
  end

  def blocked_member? # 会員が退会済、またはブロックされていればフォロー、アンフォローできない
    if @member.blocking?(current_member) || @member.disable?
      redirect_to top_path, alert: "アクセスできません"
    end
  end
end
