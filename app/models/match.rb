class Match < ApplicationRecord
  belongs_to :profile
  belongs_to :matched_profile, class_name: 'Profile'

  validates :profile_id, presence: true
  validates :matched_profile_id, presence: true
  validates :status, presence: true
end
