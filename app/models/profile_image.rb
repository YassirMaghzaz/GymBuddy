class ProfileImage < ApplicationRecord
  belongs_to :profile

  validates :image, presence: true
end
