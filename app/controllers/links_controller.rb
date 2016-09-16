class LinksController < ApplicationController
  before_action :set_link, only: [:edit, :update, :destroy]
  before_action :authenticate_user, only: [:index, :update, :destroy]

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
    # @link = Link.new
    # @popular_links = Link.order(visits: :desc).first(10)
    # @recent_links = Link.order(created_at: :desc).first(10)
  end

  # GET /links/1
  # GET /links/1.json
  def show
    if params[:slug]
      @link = Link.find_by(slug: params[:slug])
      if redirect_to @link.original, status: 301
        @link.visits += 1
        @link.save
      end
    else
      @link = Link.find(params[:id])
    end
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)
    @link.user_id = current_user ? current_user.id : 0
    respond_to do |format|
      if @link.save
        byebug
        # format.html { redirect_to @link, notice: 'Link was successfully created.' }
        # format.js { render :show, status: :created, location: @link }
        format.html { redirect_to root_path, notice: 'Link was successfully created.' }
        format.js #{ render :index, status: :created, location: @link }
        format.json { render action: 'show', status: :created, location: @link }
      else
        format.html { redirect_to :new }
        # format.js { render json: @link.errors, status: :unprocessable_entity }
        format.js { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link updated successfully.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link deleted successfully.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      # @link = Link.find_by(:slug params[:slug])
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:original)
    end
end
