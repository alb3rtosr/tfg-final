class SubscriptionsController < ApplicationController
before_action :authenticate_user!;
  def create
    if Subscription.find_by(user_id: current_user.id, topic_id: params[:topic_id])
      redirect_to topics_path      
    else 
      @subscription = Subscription.new(subscription_params)
      @subscription.user_id = current_user.id
      @subscription.save
      redirect_to topic_path(@subscription.topic_id)
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    redirect_to topic_path(@subscription.topic_id)
  end

  def subscription_params
    params.require(:subscription).permit(:topic_id,:id)
  end
end
