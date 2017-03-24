class Patient::HomeController < ApplicationController
  layout 'patient'
  protect_from_forgery

  def show
    render('patients/home')
  end


end