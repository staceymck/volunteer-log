class RolesController < ApplicationController
  before_action :find_role, :redirect_if_not_authorized, only: [:show, :edit, :update, :destroy]
  
  def index
    @roles = current_user.roles.apply_query(params[:query])
  end
  
  def show
  end

  def new
    @role = Role.new
  end

  def create
    @role = current_user.roles.build(role_params)
    if @role.save
      redirect_to role_path(@role)
    else
      render :new #make sure to add field_with_errors set up
    end
  end

  def edit
  end

  def update
    if @role.update(role_params)
      redirect_to role_path(@role)
    else
      render :edit
    end
  end

  def destroy
    @role.destroy
    redirect_to '/'
  end

  private
  def role_params
    params.require(:role).permit(:title, :description, :age_requirement, :frequency, :days, :background_check_required, :status)
  end

  def find_role
    @role = Role.find(params[:id])
  end

  def redirect_if_not_authorized
    if @role.user != current_user
      flash[:alert] = "Invalid record"
      redirect_to '/'
    end
  end
end
