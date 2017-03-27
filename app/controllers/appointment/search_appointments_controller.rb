class Appointment::SearchAppointmentsController < ApplicationController
  layout 'patient'
  #before_filter :require_user
  protect_from_forgery unless: -> { request.format.html? }

  def show
    @patient = Patient.find((User.find(session[:user_id])).patient_id)
    @doctor_name=Doctor.select(:id, :full_name)
    @doctor_types=DoctorType.all

    render('appointments/searchAppointment')
  end


  def search

    @from_date=params[:app][:from_date]
    @doctor=params[:app][:doctor_id]
    @app_type=params[:app][:app_type_id]


    @patient = Patient.find((User.find(session[:user_id])).patient_id)
    @doctor_types=DoctorType.all
    @doctor_name=Doctor.select(:id, :full_name, :doctor_type_id)

    





    #render :text => (@timeslots).inspect

  end

end
