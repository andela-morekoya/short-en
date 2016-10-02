class LinksController < ApplicationController
  before_action :set_link, only: [:edit, :update, :destroy]
  before_action :authenticate, 
                except: [ 
                          :show, 
                          :new, 
                          :create, 
                          notice: "You must be logged in to view this page"
                        ]
  layout "dashboard", only: :manage

  def show
    @link = Link.find_by(slug: params[:slug])
    if @link && @link.active
      Visit.create(
                    link_id: @link.id, 
                    user_id: current_user.id, 
                    ip_address: request.remote_ip
                  )
      redirect_to @link.original
    elsif @link && !@link.active
      render "layouts/error", locals: {reason: "inactive"}
    else
      render "layouts/error", locals: {reason: "deleted"}
    end
  end

  def new
    current_user
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
        format.html { render :form, notice: "Please paste the full URL (with http)" }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to :dashboard, notice: 'Link updated successfully.' }
      else
        format.html { redirect_to :dashboard, notice: 'Error occured' }
        format.js
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

    def new_link_params
      params.require(:link).permit(:original, :slug)
    end

    def link_params
      params.require(:link).permit(:original, :slug, :active)
    end
end
