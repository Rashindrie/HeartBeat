class Staff::HomeController < ApplicationController
  layout 'staff'

  def show
    @staff = Staff.find(params[:id])
    render('staffs/home')
  end


end