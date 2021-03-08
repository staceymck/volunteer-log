class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  before_action :redirect_if_logged_in, except: [:destroy]

  def home
    render :new
  end

  def new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:alert] = "Unsuccessful login attempt. Please try again."
      redirect_to login_path
    end
  end
  
  def omniauth
    user = User.create_from_omniauth(auth)
    if user.valid?
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:message] = user.errors.full_messages.join(“, “)
      redirect_to ‘/’
    end
 end

 def destroy
  session.clear
  redirect_to root_path
 end

  private
  def auth
    request.env['omniauth.auth']
  end
end
