class Patient::SearchPatientsController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  def index
    @doctor = Doctor.find(User.find(session[:user_id]).doctor_id)
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @patients=Patient.all

  end

end
