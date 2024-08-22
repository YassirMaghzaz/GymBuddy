class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  # User has one profile
  has_one :profile, dependent: :destroy

  # User's objectifs and preferences are accessed through their profile
  has_many :objectifs, through: :profile
  has_many :preferences, through: :profile
end
