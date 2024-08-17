# class PreferencesController < ApplicationController
#   before_action :authenticate_user!

#   def new
#     @preference = current_user.profile.preferences.build
#   end

#   def create
#     @preference = current_user.profile.preferences.build(preference_params)
#     if @preference.save
#       redirect_to notice_path, notice: 'Preferences created successfully.'
#     else
#       render :new
#     end
#   end

#   private

#   def preference_params
#     params.require(:preference).permit(:workout_time, :workout_days, :workout_type, :intensity_level, :equipment, :gym_id,)
#   end
# end
class PreferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile
  before_action :set_preference, only: [:edit, :update, :destroy]

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

  def edit; end

  def update
    if @preference.update(preference_params)
      redirect_to profile_path(@profile), notice: 'Preferences were successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @preference.destroy
    redirect_to profile_path(@profile), notice: 'Preferences were successfully deleted.'
  end

  private

  def set_profile
    @profile = current_user.profile
  end
  def preference_params
    params.require(:preference).permit(:workout_days, :workout_type)
  end
end
