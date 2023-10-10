class ProjectProfilesController < ApplicationController
  before_action :authenticate_user!
	def index
			@projects = Project.all
			@projects = current_user.projects
			@project_profiles = Project.all.where(user_id: current_user.id)
	end
end
