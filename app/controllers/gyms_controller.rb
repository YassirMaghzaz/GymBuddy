class GymsController < ApplicationController
  before_action :authenticate_user
  before_action :set_profile
  def new
    @gym = @profile.gym.new(gyms_param)
  end
  def create
    @gym = @profile.gym.new(gyms_param)
    if @gym.save
      redirect_to notice_path, notice: 'objectives created successfully.'
    else
      render :new
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def gyms_param
    params.require(:gym).permit(:name, :city)
  end
end
