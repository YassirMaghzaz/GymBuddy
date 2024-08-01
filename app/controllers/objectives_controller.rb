class ObjectivesController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_objective, only: [:show, :edit, :update, :destroy]

  def new
    @objective = current_user.objectives.build
  end

  def create
    @objective = current_user.objectives.build(objective_params)
    if @objective.save
      redirect_to new_preference_path, notice: 'Objective created successfully.'
    else
      render :new
    end
  end

  private

  def objective_params
    params.require(:objective).permit(:title, :description)
  end
  def index
    @objectives = objective.all
  end

  def show
  end

  def new
    @objective = objective.new
  end

  def create
    @objective = objective.new(objective_params)
    if @objective.save
      redirect_to @objective, notice: 'objective was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @objective.update(objective_params)
      redirect_to @objective, notice: 'objective was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @objective.destroy
    redirect_to objectives_url, notice: 'objective was successfully destroyed.'
  end

  private

  def set_objective
    @objective = objective.find(params[:id])
  end

  def objective_params
    params.require(:objective).permit(:title, :description, :status, :progress, :start_at, :end_at, :target_weight, :current_weight, :profile_id)
  end
end
