class Doctor::HomeController < ApplicationController
  layout 'patient'
  protect_from_forgery

  def show
    render('doctors/home')
  end


end