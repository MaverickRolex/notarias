class SegmentsController < ApplicationController

  def index
    @segments = Segment.all
  end

  def show
    @segment = Segment.find(params[:id])
  end

  private

  def segment_params
    params.require(:segment).permit(:name, :parent_id)
  end
end
