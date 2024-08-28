class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  before_action :set_profile, if: :user_signed_in?

  def home
  end

  def notice
  end

  def inv
  end

  def cong
  end

  private

  def set_profile
    @user_profile = current_user.profile
  end
end
