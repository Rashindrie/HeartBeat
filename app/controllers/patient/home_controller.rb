class Patient::HomeController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  def home
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:id]).first

    #for appointment summary pie chart
    @app_scheduled=Appointment.app_patient_count(@patient.id, 1)
    @app_cancelled=Appointment.app_patient_count(@patient.id, 0)
    @wl=WaitingList.wl_patient_count(@patient.id)
  end


end
