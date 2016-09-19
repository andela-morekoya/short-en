class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || dashboard_path
  end

  protected

  def no_route_found
    flash[:notice] = invalid_address
    render "not_found"
  end
end
