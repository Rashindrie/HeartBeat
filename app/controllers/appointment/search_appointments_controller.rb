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

    @date=params[:app][:from_date]
    @doctor=params[:app][:doctor_id]
    @app_type=params[:app][:app_type_id]
    @d=params[:app][:d]

    @patient = Patient.find((User.find(session[:user_id])).patient_id)
    @doctor_types=DoctorType.all
    @doctor_name=Doctor.select(:id, :full_name, :doctor_type_id)


    if @d.to_i==0
        @timeslots=TimeSlot.fromdoctor(@doctor)
       render('appointments/searchAppointment')

    elsif @d.to_i==1

      @timeslots=TimeSlot.joins(doctor: :doctor_type).where('doctors.doctor_type_id' => @app_type)
      render('appointments/searchAppointment')

    elsif @d.to_i==2
      @timeslots=TimeSlot.fromdate(@date)
      render('appointments/searchAppointment')


    end





    #render :text => (@timeslots).inspect

  end

end
