class Preference < ApplicationRecord
  belongs_to :profile

  validates :profile_id, presence: true
  #validates :gym_id, presence: true
end
