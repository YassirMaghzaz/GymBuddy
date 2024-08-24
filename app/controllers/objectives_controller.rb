class ObjectivesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def new
    @objective = @profile.objectives.build
  end

  def create
    @objective = @profile.objectives.build(objective_params)
    if @objective.save
      redirect_to new_profile_preference_path(@profile) , notice: 'objectives created successfully.'
    else
      render :new
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def objective_params
    params.require(:objective).permit(:title, :description, :status, :progress, :start_at, :end_at, :target_weight, :current_weight)
  end
end
