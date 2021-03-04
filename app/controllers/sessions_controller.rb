class SessionsController < ApplicationController
  
  def home
    if logged_in?
      render ':users/show'
    else
      render :new
    end
  end

  def new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:alert] = "Unsuccessful login attempt. Please try again."
      redirect_to login_path
    end
  end
  
  def omniauth
    user = User.create_from_omniauth(auth)
    if user.valid?
      session[:user_id] = user.id
      redirect_to user_path(user)
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
