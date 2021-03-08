class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :require_login

  private
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    redirect_to root_path if !logged_in?
  end

  def redirect_if_logged_in
    redirect_to dashboard_path if logged_in?
  end
end
