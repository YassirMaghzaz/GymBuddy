class GymsController < ApplicationController
  before_action :set_profile, only: [:new, :create]

  def new
    @gym = @profile.build_gym
  end

  def create
    @gym = @profile.build_gym(gym_params)
    if @gym.save
      redirect_to notice_path, notice: 'Gym created successfully.'
    else
      render :new
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def gym_params
    params.require(:gym).permit(:name, :city)
  end
end
