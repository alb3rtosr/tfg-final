class PostProfilesController < ApplicationController
  before_action :authenticate_user!
	def index
			@posts = current_user.posts.all
	end
end
