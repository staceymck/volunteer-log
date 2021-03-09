class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :redirect_if_logged_in, except: [:show, :destroy]
  
  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:alert] = "Unable to create account. Please try again or login."
      redirect_to signup_path
    end
  end

  def destroy
    current_user.destroy
    redirect_to login_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end 
end
