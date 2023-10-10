class Model3dsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :me]
  before_action :set_model3d, only: [:show, :edit, :update, :destroy]

  # GET /model3ds or /model3ds.json
  def index
    @model3ds = Model3d.where(public: true)
    if params[:sort] == 'description_asc'
      @model3ds = @model3ds.order(description: :asc)
    elsif params[:sort] == 'description_desc'
      @model3ds = @model3ds.order(description: :desc)
    elsif params[:sort] == 'makes_desc'
      @model3ds = @model3ds.order(makes: :desc)
    end
    if params[:search].present?
      @model3ds = @model3ds.where("description LIKE ?", "%#{params[:search]}%")
    end
    @model3ds = @model3ds.paginate(page: params[:page], per_page: 10)
  end

  # GET /model3ds/1 or /model3ds/1.json
  def show
  end

  def me
    @model3ds = Model3d.where(user_id: current_user.id)
    if params[:sort] == 'description_asc'
      @model3ds = @model3ds.order(description: :asc)
    elsif params[:sort] == 'description_desc'
      @model3ds = @model3ds.order(description: :desc)
    end
    if params[:search].present?
      @model3ds = @model3ds.where("description LIKE ?", "%#{params[:search]}%")
    end
    @model3ds = @model3ds.paginate(page: params[:page], per_page: 10)
  end

  # GET /model3ds/new
  def new
    @model3d = Model3d.new
  end

  # GET /model3ds/1/edit
  def edit
  end

  # POST /model3ds or /model3ds.json
  def create
    @model3d = Model3d.new(model3d_params)

    respond_to do |format|
      if @model3d.save
        format.html { redirect_to model3d_url(@model3d), notice: "Model3d was successfully created." }
        format.json { render :show, status: :created, location: @model3d }
        @model3d.user.update_experience_and_level(500);
      else
        format.html { render :new, notice:@model3d.errors, status: :unprocessable_entity }
        format.json { render json: @model3d.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /model3ds/1 or /model3ds/1.json
  def update
    respond_to do |format|
      if @model3d.update(model3d_params)
        format.html { redirect_to model3d_url(@model3d), notice: "Model3d was successfully updated." }
        format.json { render :show, status: :ok, location: @model3d }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @model3d.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /model3ds/1 or /model3ds/1.json
  def destroy
    @model3d.destroy

    respond_to do |format|
      format.html { redirect_to model3ds_url, notice: "Model3d was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def download
    @model3d = Model3d.find(params[:id])

    if @model3d.file.attached?
      blob = @model3d.file.blob
      send_data blob.download, filename: @model3d.file.filename.to_s, type: blob.content_type
      @model3d.makes += 1
      @model3d.save
      flash[:notice] = 'Download initiated'
    else
      flash[:error] = 'Attachment not found'
      redirect_to model3ds_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model3d
      @model3d = Model3d.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def model3d_params
      params.require(:model3d).permit(:description, :user_id, :makes, :image, :file, :public)
    end
end
