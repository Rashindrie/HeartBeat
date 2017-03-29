class Doctor::ViewAppointmentController < ApplicationController
  layout 'doctor'
  protect_from_forgery unless: -> { request.format.html? }

  def show
    @doctor = Doctor.find(User.find(session[:user_id]).doctor_id)
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)

    @appointment=Appointment.all
    render('doctors/viewDoctorAppointment')
  end


end