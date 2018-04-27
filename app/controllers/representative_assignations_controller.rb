class RepresentativeAssignationsController < ApplicationController
  before_action :load_segment
  before_action :load_search

  def new
    @users = @q.result(distinct: true)
  end

  def update
    @user = User.find(params[:id])
    @user.user_segments.where(segment: @segment).update(representative: true)
    redirect_to new_segment_representative_assignation_path(@segment)
  end

  def destroy
    @user = User.find(params[:id])
    @user.user_segments.where(segment: @segment).update(representative: false)
    redirect_to new_segment_representative_assignation_path(@segment)
  end

  private

  def load_search
    @q = @segment.users.where("users.id != ?", current_user.id).ransack(params[:q])
  end

  def load_segment
    @segment = Segment.find(params[:segment_id])
  end
end
