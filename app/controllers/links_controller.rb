class LinksController < ApplicationController
  include Messages

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

    if @link.save
      success("Link", "created")
    else
      error("Link", "created")
    end

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def update
    if @link.update(link_params)
      success("Link", "updated")
    else
      error("Link", "updated")
    end
    respond_to :js
  end

  def destroy
    Visit.delete(@link)
    @link.destroy
    respond_to do |format|
      format.html do
        redirect_to :dashboard
        success("Link", "deleted")
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
