class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.get_user(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path, notice: "Signed in successfully!"
    else
      flash[:alert] = "Invalid email or password"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out successfully"
  end
end
