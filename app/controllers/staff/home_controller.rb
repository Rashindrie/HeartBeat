class Staff::HomeController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }


  def home
    @staff = Staff.find(params[:id])
    @events=TimeSlot.all
  end


end