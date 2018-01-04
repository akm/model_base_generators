# frozen_string_literal: true
class AttachedFilesController < ApplicationController
  include Authentication
  load_and_authorize_resource except: [:index]

  before_action :set_attached_file, only: [:show, :edit, :update, :destroy]

  # GET /attached_files
  def index
    @attached_files = AttachedFile.all
  end

  # GET /attached_files/1
  def show
  end

  # GET /attached_files/new
  def new
    @attached_file = AttachedFile.new
  end

  # GET /attached_files/1/edit
  def edit
  end

  # POST /attached_files
  def create
    @attached_file = AttachedFile.new(attached_file_params)

    if @attached_file.save
      redirect_to @attached_file, notice: 'Attached file was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /attached_files/1
  def update
    if @attached_file.update(attached_file_params)
      redirect_to @attached_file, notice: 'Attached file was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /attached_files/1
  def destroy
    @attached_file.destroy
    redirect_to attached_files_url, notice: 'Attached file was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attached_file
    @attached_file = AttachedFile.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def attached_file_params
    params.require(:attached_file).permit(:issue_comment_id, :url)
  end
end
