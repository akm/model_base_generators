class PhasesController < ApplicationController
  include Authentication
  load_and_authorize_resource except: [:index]

  before_action :set_phase, only: [:show, :edit, :update, :destroy]

  # GET /phases
  def index
    @phases = Phase.all
  end

  # GET /phases/1
  def show
  end

  # GET /phases/new
  def new
    @phase = Phase.new
  end

  # GET /phases/1/edit
  def edit
  end

  # POST /phases
  def create
    @phase = Phase.new(phase_params)

    if @phase.save
      redirect_to @phase, notice: 'Phase was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /phases/1
  def update
    if @phase.update(phase_params)
      redirect_to @phase, notice: 'Phase was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /phases/1
  def destroy
    @phase.destroy
    redirect_to phases_url, notice: 'Phase was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_phase
    @phase = Phase.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def phase_params
    params.require(:phase).permit(:project_id, :name, :started_at, :finished_at)
  end
end
