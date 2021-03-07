class VolunteersController < ApplicationController
  before_action :find_volunteer, :redirect_if_not_authorized, only: [:show, :edit, :update, :destroy]
  #find_volunteer must come before redirect so that @volunteer has a value
  
  def index
    @volunteers = current_user.volunteers.apply_query(params[:query])
  end

  def show
  end
  
  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = current_user.volunteers.build(volunteer_params)
    if @volunteer.save
      redirect_to volunteer_path(@volunteer)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @volunteer.update(volunteer_params)
      redirect_to volunteer_path(@volunteer)
    else
      render :edit
    end
  end

  def destroy
    @volunteer.destroy
    redirect_to '/'
  end

  private
  def volunteer_params
    params.require(:volunteer).permit(:first_name, :last_name, :email, :phone, :occupation, :employer, :birthday, :age_group, :background_check_status, :photo_link, :interests)
  end

  def redirect_if_not_authorized
    if @volunteer.user != current_user
      flash[:alert] = "Invalid record"
      redirect_to '/'
    end
  end

  def find_volunteer
    @volunteer = Volunteer.find(params[:id])
  end
end
