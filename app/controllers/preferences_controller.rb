class PreferencesController < ApplicationController
  before_action :set_preference, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @preferences = Preference.all
  end

  def show
  end

  def new
    @preference = Preference.new
  end

  def create
    @preference = Preference.new(preference_params)
    @preference.profile = current_user.profile
    if @preference.save
      redirect_to @preference, notice: 'Preference was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @preference.update(preference_params)
      redirect_to @preference, notice: 'Preference was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @preference.destroy
    redirect_to preferences_url, notice: 'Preference was successfully destroyed.'
  end

  private

  def set_preference
    @preference = Preference.find(params[:id])
  end

  def preference_params
    params.require(:preference).permit(:workout_time, :workout_days, :workout_type, :intensity_level, :equipment, :gym_id)
  end
end
