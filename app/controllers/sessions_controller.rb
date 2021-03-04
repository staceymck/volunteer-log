class SessionsController < ApplicationController
  
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

  private
  def auth
    request.env['omniauth.auth']
  end
end
