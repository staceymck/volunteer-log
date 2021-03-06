class ActivitiesController < ApplicationController
  before_action :find_activity, :redirect_if_not_authorized, only: [:show, :edit, :update, :destroy]

  def index
    @activities = Activity.user_set(current_user).apply_query(params[:query]) #can add either .oldest or .newest to order
  end

  def show
  end

  def new
    @activity = Activity.new
    @volunteers = current_user.volunteers.alpha
    @roles = current_user.roles.alpha
  end

  def create
    @activity = current_user.activities.build(activity_params)
    if @activity.save
      redirect_to activity_path(@activity)
    else
      @volunteers = current_user.volunteers.alpha
      @roles = current_user.roles.alpha
      render :new #fields with errors
    end
  end

  def edit
    @volunteers = current_user.volunteers.alpha
    @roles = current_user.roles.alpha
  end

  def update
    if @activity.update(activity_params)
      redirect_to activity_path(@activity)
    else
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
end
