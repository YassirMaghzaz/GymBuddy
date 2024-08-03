class PreferencesController < ApplicationController
  #before_action :set_preference, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def new
    @preference = Preference.new
  end

  def create
    @preference = current_user.build_preference(preference_params)
    if @preference.save
      redirect_to "some_final_path", notice: 'Preferences created successfully.'
    else
      render :new
    end
  end

  # def index
  #   @preferences = Preference.all
  # end

  # def show
  # end

  # def new
  #   @preference = Preference.new
  # end

  # def edit
  # end

  # def update
  #   if @preference.update(preference_params)
  #     redirect_to @preference, notice: 'Preference was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   @preference.destroy
  #   redirect_to preferences_url, notice: 'Preference was successfully destroyed.'
  # end

  private

  def set_preference
    @preference = Preference.find(params[:id])
  end

  def preference_params
    params.require(:preference).permit(:workout_time, :workout_days, :workout_type, :intensity_level, :equipment, :gym_id)
  end
end
