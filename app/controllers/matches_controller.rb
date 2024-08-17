class MatchesController < ApplicationController
  before_action :set_match, only: [:accept, :reject, :destroy]

  def index
    matched_profiles_ids = Match.where(profile_id: current_user.profile.id)
                                .or(Match.where(matched_profile_id: current_user.profile.id))
                                .pluck(:matched_profile_id, :profile_id).flatten.uniq

    @profile = Profile.where.not(id: matched_profiles_ids + [current_user.profile.id])
                      .order("RANDOM()")
                      .first

  end


  def create
    @match = Match.new(profile_id: current_user.profile.id, matched_profile_id: params[:profile_id], status: "pending")
    if @match.save
      redirect_to profile_matches_path, notice: "Match request sent!"
    else
      redirect_to profile_matches_path, alert: "Something went wrong."
    end
  end

  def pending
    @pending_matches = Match.where(matched_profile_id: current_user.profile.id, status: "pending")

    @profiles = Profile.where(id: @pending_matches.pluck(:profile_id))
  end


  def accept
    @match.update(status: "accepted")
    redirect_to pending_profile_matches_path, notice: "You have accepted the match!"
  end

  def reject
    @match.update(status: "rejected")
    redirect_to pending_profile_matches_path, notice: "You have rejected the match."
  end

  def destroy
    @match.update(status: "rejected")
    redirect_to accepted_profile_matches_path, notice: "Match removed."
  end

  def accepted
    @accepted_matches = Match.where(profile_id: current_user.profile.id, status: "accepted")
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end
end
