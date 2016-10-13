class LinksController < ApplicationController
  before_action :authenticate, except: [:show, :new, :create]
  before_action :set_link, only: [:edit, :update, :destroy]
  before_action :my_links, only: [:dashboard, :create]

  def show
    @link = Link.find_by(slug: params[:slug])

    if @link && @link.active
      Visit.save_visit(@link, current_user, request.remote_ip)
      redirect_to @link.original, external: true
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
    @link = Link.new(new_link_params)
    @link.user_id = if current_user 
                      current_user.id
                    else
                      0
                    end

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

    # if @link.save
    #   redirect_to root_path, notice: "Link was successfully created"
    # else
    #   redirect_to root_path, alert: "Please enter a valid URL (with http)"
    # end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html do
          redirect_to :dashboard, notice: "Link updated successfully"
        end
      else
        format.html { redirect_to :dashboard, alert: "Error occured" }
        format.js
      end
    end

    # if @link.update(link_params)
    #   redirect_to :dashboard, notice: "Link updated successfully"
    # else
    #   redirect_to :dashboard, alert: "Error occured"
    # end
  end

  def destroy
    @link.destroy
    respond_to do |format|
      format.html do
        redirect_to :dashboard, notice: "Link deleted successfully"
      end
    end

    # redirect_to :dashboard, notice: "Link deleted successfully"
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def my_links
    if current_user
      @links = Link.where(user_id: current_user.id).order(created_at: :desc)
    end
  end

  def new_link_params
    params.require(:link).permit(:original, :slug)
  end

  def link_params
    params.require(:link).permit(:original, :slug, :active)
  end
end
