class DashboardController < ApplicationController
  before_action :authenticate_user!, notice: "You must be logged in to view this page"

  def show
    @links = Link.where(user_id: params[current_user.id])
    render "links/index"
  end

end
