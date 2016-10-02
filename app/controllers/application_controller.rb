class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def no_route_found
    flash[:notice] = :invalid_address
    render "not_found"
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    unless current_user
      redirect_to login_path, alert: "You need to log in or sign up"
    end
  end  
end
