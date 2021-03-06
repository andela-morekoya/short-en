class UsersController < ApplicationController
  include Messages

  before_action :signup_params, only: [:create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(signup_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
      success("Account", "created")
    else
      flash[:alert] = @user.errors.full_messages[0]
      render :new
    end
  end

  protected

  def signup_params
    params.require(:user).permit(
      :username,
      :email,
      :password,
      :password_confirmation
    )
  end
end
