class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def notice
  end

  def inv
  end

  def cong
  end
end
