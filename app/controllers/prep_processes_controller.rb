class PrepProcessesController < ApplicationController
  before_action :load_user
  before_action :load_segment
  before_action :load_segment_message
  before_action :load_prep_process_machine
  before_action :load_message_history
  before_action :load_political_candidacies_loader, if: -> { @prep_process_machine.current_step.is_a?(Prep::StepFour) }

  def new
    if @prep_process_machine.complete?
      redirect_to complete_segment_prep_process_path(@segment, @prep_process_machine.prep_process)
    end
  end

  def next
    @prep_process_machine.next!
    if @prep_process_machine.errors.empty?
      flash[:notice] = "¡Se avanzo al siguiente paso!"
    else
      flash[:warning] = @prep_process_machine.errors.full_messages.last
    end
    redirect_to new_segment_prep_process_path(@segment)
  end

  def previous
    @prep_process_machine.previous!
  end

  def complete
    if !@prep_process_machine.complete!
      flash[:warning] = "No pudo completarse la captura de datos"
      redirect_to :new
    end
    flash[:notice] = "¡Gracias por completar la captura de información de su casilla!"
  end

  private

  def load_message_history
    @previous_messages = current_user.segment_messages.where(segment: @segment)
  end

  def load_prep_process_machine
    @prep_process_machine = PrepProcessMachine.new(segment: @segment, user: @user)
    @prep_process_machine.find_or_create
  end

  def load_political_candidacies_loader
    @political_candidacies_loader = PoliticalCandidaciesLoader.new(@segment)
  end

  def load_segment_message
    @segment_message = SegmentMessage.new(segment: @segment)
  end

  def load_user
    @user = params[:user_id] ? User.find(params[:user_id]) : current_user
  end

  def load_segment
    @segment = Segment.find(params[:segment_id])
  end
end
