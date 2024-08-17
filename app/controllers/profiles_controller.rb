class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update]

  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to new_objectif_path, notice: 'Profile created successfully.'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :age, :gender, :location, :bio, :availability, :level, :photo)
  end
end
