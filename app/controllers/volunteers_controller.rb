class VolunteersController < ApplicationController
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

  def show
    @volunteer = Volunteer.find(params[:id])
  end

  private
  def volunteer_params
    params.require(:volunteer).permit(:first_name, :last_name, :email, :phone, :occupation, :employer, :birthday, :age_group, :background_check_status, :photo_link, :interests)
  end
end
