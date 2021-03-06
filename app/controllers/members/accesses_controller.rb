class Members::AccessesController < Members::ApplicationController
  def index
    if params[:member_id].to_i == current_member.id
      @accesses = current_member.visited.includes(:visitor)
      @accesses = @accesses.page(params[:page])
      @accesses = @accesses.where.not(visitor_id: current_member.blocker_member)
    else
      redirect_to top_path, alert: "アクセスが拒否されました"
    end
  end

  def create
    unless params[:member_id].to_i == current_member.id
      current_member.visitor.create(visited_id: params[:member_id])
    end
  end
end
