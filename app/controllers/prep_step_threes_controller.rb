class PrepStepThreesController < ApplicationController
  before_action :load_prep_step_three

  def update
    @prep_step_three.update prep_step_three_params
  end

  private

  def prep_step_three_params
    params.require(:prep_step_three).permit(:voters_count)
  end

  def load_prep_step_three
    @prep_step_three = Prep::StepThree.find(params[:id])
  end
end
