class LinksController < ApplicationController
  before_action :set_link, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:manage, :index, :update, :destroy,
    notice: "You must be logged in to view this page"]
  layout "dashboard", only: :manage

  def show
    if params[:slug]
      @link = Link.find_by(slug: params[:slug])
      if @link && @link.active
        if redirect_to @link.original, status: 301
          @link.visits += 1
          @link.save
        end
      else
        render "layouts/not_found"
      end
    else
      @link = Link.find_by(id: params[:id])
    end
  end

  def new
    @link = Link.new
  end

  def edit
    render "index"
  end

  def create
    @link = Link.new(new_link_params)
    @link.user_id = current_user ? current_user.id : 0
    respond_to do |format|
      if @link.save
        format.html { redirect_to root_path, notice: 'Link was successfully created.' }
        format.js 
      else
        format.html { redirect_to :new }
        # format.js { render json: @link.errors, status: :unprocessable_entity }
        format.js { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to :dashboard, notice: 'Link updated successfully.' }
      else
        format.html { render :index }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def manage
    @link = Link.new
    @links = Link.where(user_id: current_user.id).order(created_at: :desc)
    render "index"
  end
    
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to :dashboard, notice: 'Link deleted successfully.' }
      format.json { head :no_content }
    end
  end

  private
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def new_link_params
      params.require(:link).permit(:original)
    end

    def link_params
      params.require(:link).permit(:all)
    end
end
