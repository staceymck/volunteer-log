class ActivitiesController < ApplicationController
  before_action :find_activity, :redirect_if_not_authorized, only: [:show, :edit, :update, :destroy]
  before_action :validate_role_and_volunteer_belong_to_user, only: [:create, :update]
  
  def index
    flash.now[:search_guide] = "Please enter a name" if params[:query] == ""

    if params[:volunteer_id] && @volunteer = current_user.volunteers.find_by(id: params[:volunteer_id]) #handle nested route /volunteers/:volunteer_id/activities
      @activities = @volunteer.activities.apply_query(params[:query])
    else
      flash.now[:alert] = "Volunteer not found" if params[:volunteer_id]
      @activities = current_user.activities.apply_query(params[:query])
    end
  end

  def show
  end

  def new
    if params[:volunteer_id] && @volunteer = current_user.volunteers.find_by(id: params[:volunteer_id])
      @activity = @volunteer.activities.build
    else
      flash[:alert] = "Volunteer not found" if params[:volunteer_id]
      @activity = Activity.new
      set_user_volunteers
    end
    set_user_roles
  end

  def create
    @activity = current_user.activities.build(activity_params)
    if @activity.save
      redirect_to activity_path(@activity)
    else 
      if params[:volunteer_id] #if nested form has errors, need to render with @volunteer value still set
        @volunteer = current_user.volunteers.find_by(id: params[:volunteer_id]) 
      else
        set_user_volunteers
      end
      set_user_roles
      render :new
    end
  end

  def edit
    set_user_volunteers
    set_user_roles
  end

  def update
    if @activity.update(activity_params)
      redirect_to activity_path(@activity)
    else
      set_user_volunteers
      set_user_roles
      render :edit
    end
  end

  def destroy
    @activity.destroy
    redirect_to dashboard_path
  end

  private
  def activity_params
    params.require(:activity).permit(:date, :duration, :volunteer_id, :role_id)
  end

  def find_activity
    @activity = Activity.find(params[:id])
  end

  def redirect_if_not_authorized
    if @activity.volunteer.user != current_user
      flash[:alert] = "Invalid record"
      redirect_to dashboard_path
    end
  end

  def validate_role_and_volunteer_belong_to_user
    role_id = params[:activity][:role_id]
    volunteer_id = params[:volunteer_id] || params[:activity][:volunteer_id]
    if (role_id != "" && current_user.roles.find_by(id: role_id).nil?) || (volunteer_id != "" && current_user.volunteers.find_by(id: volunteer_id).nil?)
      flash[:alert] = "You can only save/alter activity records for volunteers and roles you've created"
      redirect_to new_activity_path
    end
  end

  def set_user_volunteers
    @volunteers = current_user.volunteers.alpha
  end

  def set_user_roles
    @roles = current_user.roles.alpha
  end
end
