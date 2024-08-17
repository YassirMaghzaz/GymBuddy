# class MatchesController < ApplicationController
#   before_action :set_match, only: [:show, :edit, :update, :destroy]
#   before_action :authenticate_user!

#   def index
#     @matches = Match.all
#   end

#   def show
#   end

#   def new
#     @match = Match.new
#   end

#   def create
#     @match = Match.new(match_params)
#     if @match.save
#       redirect_to @match, notice: 'Match was successfully created.'
#     else
#       render :new
#     end
#   end

#   def edit
#   end

#   def update
#     if @match.update(match_params)
#       redirect_to @match, notice: 'Match was successfully updated.'
#     else
#       render :edit
#     end
#   end

#   def destroy
#     @match.destroy
#     redirect_to matches_url, notice: 'Match was successfully destroyed.'
#   end

#   private

#   def set_match
#     @match = Match.find(params[:id])
#   end

#   def match_params
#     params.require(:match).permit(:status, :profile_id, :matched_profile_id)
#   end
# end
class MatchesController < ApplicationController
  before_action :authenticate_user!

  def create
    match_params = {
      profile_id: current_user.profile.id,
      matched_profile_id: params[:matched_profile_id],
      status: params[:status]
    }
    Match.find_or_create_by(match_params)
    # Fetch the next unmatched profile
    matched_user_ids = Match.where(profile_id: current_user.profile.id).pluck(:matched_profile_id)
    @user = User.includes(profile: [:objectifs, :preferences])
                .where.not(id: current_user.id)
                .where.not(id: matched_user_ids)
                .joins(:profile)
                .where(profiles: { location: current_user.profile.location })
                .where(profiles: { gym_id: current_user.profile.preferences.pluck(:gym_id) })
                .sample

    respond_to do |format|
      format.html { redirect_to users_path } # Redirects to users index (if needed)
      format.js   # Renders index.js.erb for AJAX requests
    end
  end
end
