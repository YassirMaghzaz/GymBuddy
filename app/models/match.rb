class Match < ApplicationRecord
  belongs_to :profile
  belongs_to :matched_profile, class_name: 'Profile'
  belongs_to :matcher, class_name: 'Profile', foreign_key: 'matcher_id'

  validates :profile_id, :matched_profile_id, :matcher_id, presence: true
  validates :status, presence: true
end
