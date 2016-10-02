class UsersController < ApplicationController
before_action :signup_params, only: [:create]
before_action :update_params, only: [ :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(signup_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path, notice: "Account created successfully!"
    else
      flash[:alert] = @user.errors.full_messages[0]
      render :new
    end
  end

  def update
    @user = User.update(update_params)
  end

  def destroy
    @user = User.find(params[:id])
  end

  protected

  def signup_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
