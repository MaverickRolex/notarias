class PrepStepTwosController < ApplicationController
  def update
    @step_two = Prep::StepTwo.find(params[:id])
    @step_two.update(step_params)
  end

  private

  def step_params
    params.require(:prep_step_two).permit(:males, :females)
  end
end
