class Admin::HomeController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  #show doctor home
  def home
    @admin = User.find(params[:id])
  end
end
