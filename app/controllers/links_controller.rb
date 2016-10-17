class LinksController < ApplicationController
  before_action :authenticate, except: [:show, :new, :create]
  before_action :set_link, only: [:edit, :update, :destroy]
  before_action :my_links, only: [:dashboard, :create, :update]

  def show
    @link = Link.find_by(slug: params[:slug])

    if @link && @link.active
      Visit.save_visit(@link, current_user, request.remote_ip)
      redirect_to @link.original
    elsif @link && !@link.active
      render "layouts/error", locals: { reason: "inactive" }
    else
      render "layouts/error", locals: { reason: "deleted" }
    end
  end

  def dashboard
    @link = Link.new
  end

  def new
    @link = Link.new
  end

  def edit
  end

  def create
    @link = Link.new(link_params)
    @link.user_id = (current_user.id if current_user) || 0

    respond_to do |format|
      if @link.save
        format.html do
          redirect_to root_path, notice: "Link was successfully created"
        end
      else
        format.html do
          redirect_to root_path, alert: "Please enter a valid URL (with http)"
        end
      end
      format.js
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.js do
          flash[:notice] = "Link updated successfully"
        end
      else
        format.js do
          flash[:alert] = "Error occured"
        end
      end
    end
  end

  def destroy
    Visit.delete(@link)
    @link.destroy
    respond_to do |format|
      format.html do
        redirect_to :dashboard, notice: "Link deleted successfully"
      end
    end
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def my_links
    @links = Link.get_my_links(current_user)
  end

  def link_params
    params.require(:link).permit(:original, :slug, :active)
  end
end
