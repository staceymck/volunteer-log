class ActivitiesController < ApplicationController
  before_action :find_activity, :redirect_if_not_authorized, only: [:show, :edit, :update, :destroy]
  
  def index
    flash.now[:search_guide] = "Please enter a name" if params[:query] == ""

    #handle nested route /volunteers/:volunteer_id/activities
    if params[:volunteer_id] && @volunteer = current_user.volunteers.find_by(id: params[:volunteer_id])
      @activities = @volunteer.activities.apply_query(params[:query])
    else
      flash.now[:alert] = "Volunteer not found" if params[:volunteer_id]
      @activities = current_user.activities.apply_query(params[:query])
    end

    #handle new users and no results
    set_message if @activities.empty?
  end

  # def index
  #   flash.now[:alert] = "Please enter a name" if params[:query] == ""
  #   @activities = current_user.activities.apply_query(params[:query])
  #   flash.now[:alert] = "No results found" if @activities.empty? #this could be set up as error message maybe if desired below table headers
  # end

  def show
  end

  def new #redirects to activity page if your save is unsuccessful and you press refresh - why?
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
    else #if form has errors, need to render with @volunteer value still set
      if params[:volunteer_id]
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

  def set_message
    if current_user.activities.empty? || @volunteer.activities.empty?
      @message = "No activities to display"
    else
      @message = "No results found"
    end
  end
end
