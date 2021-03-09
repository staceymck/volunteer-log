class RoleVolunteersController < ApplicationController
  
  def index
    if @role = current_user.roles.find_by(id: params[:role_id])
      @volunteers = @role.volunteers.alpha 
      flash.now[:alert] = "No results" if @volunteers.empty? #could set this up as an error maybe and display under table headers?
      render :'/volunteers/index'
    else
      flash[:alert] = "No matching role found"
      redirect_to roles_path
    end
  end
end