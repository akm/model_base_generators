class ProjectAssignmentsController < ApplicationController
  include Authentication
  load_and_authorize_resource except: [:index]

  before_action :set_project_assignment, only: [:show, :edit, :update, :destroy]

  # GET /project_assignments
  def index
    @project_assignments = ProjectAssignment.all
  end

  # GET /project_assignments/1
  def show
  end

  # GET /project_assignments/new
  def new
    @project_assignment = ProjectAssignment.new
  end

  # GET /project_assignments/1/edit
  def edit
  end

  # POST /project_assignments
  def create
    @project_assignment = ProjectAssignment.new(project_assignment_params)

    if @project_assignment.save
      redirect_to @project_assignment, notice: 'Project assignment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /project_assignments/1
  def update
    if @project_assignment.update(project_assignment_params)
      redirect_to @project_assignment, notice: 'Project assignment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /project_assignments/1
  def destroy
    @project_assignment.destroy
    redirect_to project_assignments_url, notice: 'Project assignment was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project_assignment
    @project_assignment = ProjectAssignment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def project_assignment_params
    params.require(:project_assignment).permit(:project_id, :user_id)
  end
end
