# class ObjectifsController < ApplicationController
#   before_action :authenticate_user!
#   before_action :set_profile
#   # before_action :set_objectif, only: [:show, :edit, :update, :destroy]

#   def new
#     @objectif = Objectif.new
#   end

#   def create
#     @objectif = @profile.objectifs.build(objectif_params)
#     if @objectif.save
#       redirect_to new_preference_path, notice: 'objectif created successfully.'
#     else
#       render :new
#     end
#   end

#   # def index
#   #   @objectifs = @profile.objectifs.all
#   # end

#   # def show
#   # end

#   # def edit
#   # end

#   # def update
#   #   if @objectif.update(objectif_params)
#   #     redirect_to @objectif, notice: 'objectif was successfully updated.'
#   #   else
#   #     render :edit
#   #   end
#   # end

#   # def destroy
#   #   @objectif.destroy
#   #   redirect_to objectifs_url, notice: 'objectif was successfully destroyed.'
#   # end

#   private

#   def set_profile
#     @profile = current_user.profile
#   end

#   # def set_objectif
#   #   @objectif = @profile.objectifs.find(params[:id])
#   # end

#   def objectif_params
#     params.require(:objectif).permit(:title, :description, :status, :progress, :start_at, :end_at, :target_weight, :current_weight)
#   end
# end

class ObjectifsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile
  before_action :set_objectif, only: [:edit, :update, :destroy]

  def new
    @objectif = @profile.objectifs.new
  end

  def create
    @objectif = @profile.objectifs.build(objectif_params)
    if @objectif.save
      redirect_to new_preference_path, notice: 'Objectif created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @objectif.update(objectif_params)
      redirect_to profile_path(@profile), notice: 'Objectif was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @objectif.destroy
    redirect_to profile_path(@profile), notice: 'Objectif was successfully deleted.'
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def set_objectif
    @objectif = @profile.objectifs.find(params[:id])
  end

  def objectif_params
    params.require(:objectif).permit(:title, :description, :status, :progress, :start_at, :end_at, :target_weight, :current_weight)
  end
end
