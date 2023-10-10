class PostsController < ApplicationController
  # before_action :find_topic, only: [:new]
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :valid_user, only: [:edit, :update, :destroy]

  def index
    if current_user && current_user.subscriptions.any?
      @posts = []
      current_user.subscriptions.each do |subscription|
        topic = subscription.topic
        @posts.concat(topic.posts)
      end
    
      # Sort the @posts array by created_at in reverse order (newest first)
      @posts.sort_by! { |post| post.created_at }.reverse!
    else
      # Fetch all posts from the database
      @posts = Post.all.order(created_at: :desc)
    end
    
  end

  def show
    @flags_count = @post.flags.count
    @current_user_flagged = current_user ? @post.flags.exists?(user_id: current_user.id) : false
    @comment = @post.comments.build
    @comments = @post.comments
  end

  def new
    @post = current_user.posts.new(topic_id: params[:topic_id])
    @topics = Topic.all.map{ |c| [c.title, c.id] }
  end

  def edit
    @topics = Topic.all.map{ |c| [c.title, c.id] }
  end

  def create
    @topics = Topic.all.map{ |c| [c.title, c.id] }

    @post = current_user.posts.new(post_params)
    points_earned = 250
    current_user.update_experience_and_level(points_earned)
    # @post.topic_id = @topic.id
    # @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to topic_post_path(@post.topic_id, @post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post.topic_id = params[:topic_id]
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :user_id, :topic_id)
    end

    def find_topic
      @topic = Topic.find(params[:topic_id])
    end

    def valid_user
     unless @post.user_id == current_user.id
      flash[:notice] = 'Access denied as you are not owner of this post'
      redirect_to root_path
     end
    end
end
