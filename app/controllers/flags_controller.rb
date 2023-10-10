class FlagsController < ApplicationController
  before_action :authenticate_user!

  def create
    @flaggable = find_flaggable

    if @flaggable.flags.where(user: current_user).exists?
      flash[:notice] = "You have already flagged this project."
    else
      @flag = @flaggable.flags.build(user: current_user)

      if @flag.save
        flash[:notice] = "Flagged successfully."
      else
        flash[:alert] = "Flagging failed."
      end
    end
    redirect_to_flaggable_path


  end

  private

  def find_flaggable
    # Ensure that the flaggable_type parameter is present and valid
    flaggable_type = params[:flaggable_type]
    raise ActiveRecord::RecordNotFound unless flaggable_type.in?(%w(User Post Project))

    # Retrieve the object based on flaggable_type and flaggable_id
    flaggable_id = params[:flaggable_id]
    flaggable_type.classify.constantize.find(flaggable_id)
  end

  def redirect_to_flaggable_path
    if @flaggable.is_a?(Project)
      redirect_to project_path(@flaggable)
    elsif @flaggable.is_a?(Post)
      redirect_to post_path(@flaggable)
    else
      redirect_back fallback_location: root_path
    end
  end
  
end
