class TopicsController < ApplicationController
  before_action :set_topic, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :valid_user_level, only: [:edit, :update, :destroy, :new]

  def index
    @topics = Topic.all
  end

  def show
    @posts = @topic.posts
    @subscriber_count = @topic.subscribers.count
    @is_subscribed = user_signed_in? ? Subscription.where(topic_id: @topic.id, user_id: current_user.id).any? : false
    @subscription = Subscription.new
  end

  def new
    @topic = current_user.topics.new
  end

  def edit
  end

  def create
    @topic = current_user.topics.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to topic_url(@topic), notice: "Topic was successfully created." }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topic_url(@topic), notice: "Topic was successfully updated." }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url, notice: "Topic was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:title, :description)
    end

    def valid_user_level
      if current_user && current_user.level < 2
       flash[:notice] = 'You must be level 2 or higher to create topics.'
       redirect_to root_path
      end
     end
end
