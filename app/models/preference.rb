class Preference < ApplicationRecord
  belongs_to :profile
  belongs_to :gym

  validates :profile_id, presence: true
  #validates :gym_id, presence: true
end
