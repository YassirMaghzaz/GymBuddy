class Objectif < ApplicationRecord
  belongs_to :profile

  validates :profile_id, presence: true
  validates :start_at, :end_at, presence: true

  # Calcul de la progression basée sur les dates start_at et end_at
  def date_based_progress
    return 0 if start_at.nil? || end_at.nil? || end_at <= start_at

    total_duration = (end_at.to_date - start_at.to_date).to_f
    elapsed_duration = (Date.today - start_at.to_date).to_f

    progress = (elapsed_duration / total_duration) * 100
    progress > 100 ? 100 : progress.round(2)
  end
end
