class ActivitiesController < ApplicationController
  before_action :find_activity, :redirect_if_not_authorized, only: [:show, :edit, :update, :destroy]
  #is there a way to refactor the set_user_roles and volunteers into a before_render action?
  
  def index
    if params[:volunteer_id] && @volunteer = current_user.volunteers.find_by(id: params[:volunteer_id])
      @activities = @volunteer.activities.apply_query(params[:query])
    else
      @error = "Volunteer doesn't exist" if params[:volunteer_id]
      @activities = Activity.user_set(current_user).apply_query(params[:query])
    end
  end

  def show
  end

  def new #redirects to activity page if your save is unsuccessful and you press refresh - why?
    set_user_roles
    if params[:volunteer_id] && @volunteer = current_user.volunteers.find_by(id: params[:volunteer_id])
      @activity = @volunteer.activities.build
    else
      @error = "Volunteer doesn't exist" if params[:volunteer_id]
      @activity = Activity.new
      set_user_volunteers
    end
  end

  def create
    @activity = current_user.activities.build(activity_params)
    if @activity.save
      redirect_to activity_path(@activity)
    else #if form has errors, need to render with @volunteer value still set
      if params[:volunteer_id]
        @volunteer = current_user.volunteers.find_by(id: params[:volunteer_id])
      else
        set_user_volunteers
      end
      set_user_roles
      render :new #fields with errors
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
      render :edit #fields with errors
    end
  end

  def destroy
    @activity.destroy
    redirect_to '/'
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
      redirect_to '/'
    end
  end

  def set_user_volunteers
    @volunteers = current_user.volunteers.alpha
  end

  def set_user_roles
    @roles = current_user.roles.alpha
  end
end
