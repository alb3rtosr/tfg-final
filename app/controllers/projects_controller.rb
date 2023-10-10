class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_project, only: %i[ show edit update destroy ]

  def index
    @projects = Project.all
    @project_users = ProjectUser.all
  end

  def show
    @project = Project.find(params[:id])
    @flags_count = @project.flags.count
    @current_user_flagged = @project.flags.exists?(user_id: current_user.id)

  end

  def new
    @project = current_user.projects.new
  end

  def edit
  end

  def create
    @project = current_user.projects.new(project_params)
    @project.user_id = current_user.id
      # Calculate experience points for the user
      points_earned = 500
      current_user.update_experience_and_level(points_earned)
      # Create the project user
      @project_user = ProjectUser.new
      @project_user.project = @project
      @project_user.user = current_user
      @project_user.role = :commissioner
     respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    @project = Project.find(params[:id])

    if @project.accepted?
      flash[:error] = "This project has already been accepted."
      render :show
    else
      @project_user = ProjectUser.new(project: @project, user: current_user, role: :project_owner)      
      if @project_user.save
        redirect_to projects_path
      else
        flash[:error] = "You have not accepted the project yet."
        redirect_to root_path
      end
    end
  end
 
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :description, :visibility, :role,  :user_id, :state, files: [])
    end
end
