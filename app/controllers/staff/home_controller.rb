class Staff::HomeController < ApplicationController
  layout 'patient'
  protect_from_forgery

  def show
    render('staffs/home')
  end


end