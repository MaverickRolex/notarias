class TransferUsersController < ApplicationController
  before_action :fix_params_from_search, only: [:select]
  before_action :load_from_to_segments, only: [:select, :create]

  def new
    @segments = load_managed_segments_tree
  end

  def select
    @q = User.non_representative_users_from_segment(@from_segment).ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def create
    @users = User.find(params[:users_ids])
    @user_segments = UserSegment.where user: @users, segment: @from_segment
    UserSegment.transaction do
      @user_segments.update(segment_id: @to_segment.id)
      raise ActiveRecord::Rollback if @user_segments.any? { |user_segment| !user_segment.errors.blank? }
    end
  end

  private

  def load_managed_segments_tree
    if current_user.representative?
      current_user.represented_segments
    else
      Segment.roots
    end
  end

  def fix_params_from_search
    if !(params[:from_id] && params[:to_id]) && (params[:q] && params[:q][:from_id] && params[:q][:to_id])
      params[:from_id] = params[:q][:from_id]
      params[:to_id] = params[:q][:to_id]
    end
  end

  def load_from_to_segments
    @from_segment = Segment.find(params[:from_id])
    @to_segment = Segment.find(params[:to_id])
  end
end
