class Profile < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true

  has_one_attached :photo

  has_many :preferences
  has_many :objectifs

  has_many :initiated_matches, class_name: 'Match', foreign_key: 'profile_id'
  has_many :received_matches, class_name: 'Match', foreign_key: 'matched_profile_id'
end
