# class UsersController < ApplicationController
#   before_action :authenticate_user!

#   def index
#     Match.create(status: "accepted", profile_id: current_user.id, matched_profile_id: params[:matched_profile_id]) if params[:accepted] == "true"
#     Match.create(status: "rejected", profile_id: current_user.id, matched_profile_id: params[:matched_profile_id]) if params[:accepted] == "false"

#     matched_user_ids = Match.where(profile_id: current_user.id).pluck(:matched_profile_id)
#     @user = User.includes(profile: [:objectifs, :preferences])
#                 .where.not(id: current_user.id)
#                 .where.not(id: matched_user_ids)
#                 .sample

#     respond_to do |format|
#       format.html # renders the default index.html.erb
#       format.js   # renders index.js.erb if it's an AJAX request
#     end
#   end
# end
class UsersController < ApplicationController
  before_action :set_user, only: [:like, :dislike]

  def index
    # Obtenir les IDs des utilisateurs déjà likés ou dislikés par l'utilisateur actuel
    liked_or_disliked_ids = Match.where(profile: current_user.profile).pluck(:matched_profile_id)

    # Exclure ces utilisateurs de la sélection
    @user = User.where.not(id: [current_user.id, *liked_or_disliked_ids]).sample

    # Si aucun utilisateur n'est disponible, afficher un message
    @no_more_profiles = @user.nil?
  end

  def like
    create_or_update_match(true)
    redirect_to users_path, notice: "Request sent! Your buddy has been notified. 🔔"
  end

  def dislike
    create_or_update_match(false)
    redirect_to users_path
  end

  private

  def create_or_update_match(accepted)
    match = Match.find_or_initialize_by(profile_id: current_user.profile.id, matched_profile_id: @user.profile.id)
    match.status = accepted ? 'accepted' : 'rejected'
    match.save
  end

  def set_user
    @user = User.find(params[:matched_profile_id])
  end
end
