class PreferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def new
    @preference = @profile.preferences.new
  end

  def create
    @preference = @profile.preferences.new(preference_params)
    if @preference.save
      redirect_to new_profile_gym_path(@profile), notice: 'Preferences created successfully.'
    else
      render :new
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end
  def preference_params
    params.require(:preference).permit(:workout_days, :workout_type)
  end
end
