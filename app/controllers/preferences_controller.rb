class PreferencesController < ApplicationController
  before_action :authenticate_user!

  def new
    @preference = current_user.profile.preferences.build
  end

  def create
    @preference = current_user.profile.preferences.build(preference_params)
    if @preference.save
      redirect_to notice_path, notice: 'Preferences created successfully.'
    else
      render :new
    end
  end

  private

  def preference_params
    params.require(:preference).permit(:workout_time, :workout_days, :workout_type, :intensity_level, :equipment, :gym_id,)
  end
end
