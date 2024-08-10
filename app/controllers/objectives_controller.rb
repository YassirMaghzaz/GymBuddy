class ObjectivesController < ApplicationController
  before_action :authenticate_user!

  def new
    @objective = current_user.profile.objectives.build
  end

  def create
    @objective = current_user.profile.objectives.build(objective_params)
    if @objective.save
      redirect_to notice_path, notice: 'objectives created successfully.'
    else
      render :new
    end
  end

  private

  def objective_params
    params.require(:objective).permit(:title, :description, :status, :progress, :start_at, :end_at, :target_weight, :current_weight)
  end
end
