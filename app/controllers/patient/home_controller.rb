class Patient::HomeController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  def home
    @patient = Patient.find(params[:id])
    @app_scheduled=Appointment.app_patient_count(@patient.id, 1)
    @app_cancelled=Appointment.app_patient_count(@patient.id, 0)
    @wl=WaitingList.wl_patient_count(@patient.id)
  end


end
