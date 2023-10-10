class ProjectUserController < ApplicationController
  before_action :set_project_user, only: %i[ show edit update destroy ]

  # def create
  #   project_user_params = params.require(:project_user).permit(:role)
  #   @project_user = ProjectUser.new(project_user_params)

  #   if @project_user.save
  #     redirect_to @project_user, notice: "Project user was successfully created."
  #   else
  #     render :new
  #   end
  # end

  # def update
  #   project_user_params = params.require(:project_user).permit(:role)
  #   @project_user = ProjectUser.find(params[:id])

  #   if @project_user.update(project_user_params)
  #     redirect_to @project_user, notice: "Project user was successfully updated."
  #   else
  #     render :edit
  #   end
  # end

  # private

  #   def set_project_user
  #     @project_user = ProjectUser.find(params[:id])
  #   end
end
