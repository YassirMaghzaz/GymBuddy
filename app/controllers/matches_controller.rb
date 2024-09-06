class MatchesController < ApplicationController
  before_action :set_match, only: [:accept, :reject, :destroy]
  before_action :random_profile, only: :index
  before_action :set_profile, if: :user_signed_in?
  def index
  end

  def create
    accepted = params[:accepted] == "true"
    @match = Match.new(profile_id: current_user.profile.id,
                       matched_profile_id: params[:profile_id],
                       matcher_id: current_user.profile.id,
                       status: accepted ? "pending" : "rejected")
    if @match.save && accepted
      redirect_to request_path
    elsif !accepted
      redirect_to matches_path
    else
      redirect_to matches_path, alert: "Something went wrong."
    end
  end

  def requests
    @pending_matches = Match.where(matched_profile_id: current_user.profile.id, status: "pending")
    @profiles = Profile.where(id: @pending_matches.pluck(:profile_id))
  end

  def details
    @profile = Profile.find(params[:profile_id])
    @match = Match.find(params[:match_id])
  end
  def accept
    @match.update(status: "accepted")
    redirect_to congrats_path
  end

  def reject
    @match.update(status: "rejected")
    redirect_to requests_profile_matches_path
  end

  def destroy
    @match.update(status: "rejected")
    redirect_to accept_profile_matches_path, notice: "Match removed."
  end

  def buddies
    @accepted_matches = Match.where("(profile_id = :profile_id OR matched_profile_id = :profile_id OR matcher_id = :profile_id) AND status = 'accepted'", profile_id: current_user.profile.id)
    @profiles = Profile.where(id: @accepted_matches.pluck(:profile_id, :matched_profile_id, :matcher_id).flatten.uniq)
  end


  private

  def set_match
    @match = Match.find(params[:id])
  end

  def random_profile
    matched_profiles_ids = Match.where(profile_id: current_user.profile.id)
    .or(Match.where(matched_profile_id: current_user.profile.id))
    .pluck(:matched_profile_id, :profile_id).flatten.uniq

    @profile = Profile.where.not(id: [matched_profiles_ids + [current_user.profile.id]])
    .sample
  end

  private

  def set_profile
    @user_profile = current_user.profile
  end
end
