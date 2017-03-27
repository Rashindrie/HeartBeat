class Patient::HomeController < ApplicationController
  layout 'patient'

  def show
    @patient = Patient.find(params[:id])

    render('patients/home')
  end


end