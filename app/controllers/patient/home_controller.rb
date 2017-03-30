class Patient::HomeController < ApplicationController
  layout 'patient'
  protect_from_forgery unless: -> { request.format.html? }

  def show
    @patient = Patient.find(params[:id])
    render('patients/home')
  end


end