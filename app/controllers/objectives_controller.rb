class ObjectivesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def new
    @objective = @profile.objectives.new
  end

  def create
    @objective = @profile.objective.new(objective_params)
    if @objective.save
      redirect_to notice_path, notice: 'objectives created successfully.'
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
