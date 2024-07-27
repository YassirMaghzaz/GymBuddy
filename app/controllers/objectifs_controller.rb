class ObjectifsController < ApplicationController
  before_action :set_objectif, only: [:show, :edit, :update, :destroy]

  def index
    @objectifs = Objectif.all
  end

  def show
  end

  def new
    @objectif = objectif.new
  end

  def create
    @objectif = objectif.new(objectif_params)
    if @objectif.save
      redirect_to @objectif, notice: 'objectif was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @objectif.update(objectif_params)
      redirect_to @objectif, notice: 'objectif was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @objectif.destroy
    redirect_to objectifs_url, notice: 'objectif was successfully destroyed.'
  end

  private

  def set_objectif
    @objectif = objectif.find(params[:id])
  end

  def objectif_params
    params.require(:objectif).permit(:title, :description, :status, :progress, :start_at, :end_at, :target_weight, :current_weight, :profile_id)
  end
end
