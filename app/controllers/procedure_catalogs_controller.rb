class ProcedureCatalogsController < ApplicationController

  def index
    @procedure = Procedure.all.order(:id)
  end

  def show
    @procedure = Procedure.find(params[:id])
  end

  def new
    @procedure = Procedure.new
  end

  def edit
    @procedure = Procedure.find(params[:id])
  end

    def create
    procedure = Procedure.new(procedure_params)
    if procedure.save
      redirect_to procedures_path
    else
      redirect_to new_procedure_path
    end
  end

  def update
    @procedure = Procedure.find(params[:id])

    if @procedure.update(procedure_params)
      redirect_to procedures_path
    else
      redirect_to edit_procedure_path
    end
  end

  def destroy
    @procedure = Procedure.find(params[:id])
    @procedure.destroy

    redirect_to procedures_path
  end


  private

  def procedure_params
    params.require(:procedure).
      permit(:name, :creator_user_id, :version)
  end

end