class IssueCommentsController < ApplicationController
  include Authentication
  load_and_authorize_resource except: [:index]

  before_action :set_issue_comment, only: [:show, :edit, :update, :destroy]

  # GET /issue_comments
  def index
    @issue_comments = IssueComment.all
  end

  # GET /issue_comments/1
  def show
  end

  # GET /issue_comments/new
  def new
    @issue_comment = IssueComment.new
  end

  # GET /issue_comments/1/edit
  def edit
  end

  # POST /issue_comments
  def create
    @issue_comment = IssueComment.new(issue_comment_params)

    if @issue_comment.save
      redirect_to @issue_comment, notice: 'Issue comment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /issue_comments/1
  def update
    if @issue_comment.update(issue_comment_params)
      redirect_to @issue_comment, notice: 'Issue comment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /issue_comments/1
  def destroy
    @issue_comment.destroy
    redirect_to issue_comments_url, notice: 'Issue comment was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_issue_comment
    @issue_comment = IssueComment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def issue_comment_params
    params.require(:issue_comment).permit(:issue_id, :user_id, :description)
  end
end
