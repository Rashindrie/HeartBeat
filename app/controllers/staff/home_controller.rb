class Staff::HomeController < ApplicationController
  layout 'staff'
  protect_from_forgery unless: -> { request.format.html? }
  def show
    @staff = Staff.find(params[:id])
    render('staffs/home')
  end


end