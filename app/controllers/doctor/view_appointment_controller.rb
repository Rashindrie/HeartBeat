class Doctor::ViewAppointmentController < ApplicationController
  layout 'doctor'
  protect_from_forgery unless: -> { request.format.html? }

  def show
    @doctor = Doctor.find(User.find(session[:user_id]).doctor_id)
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)



    @appointments=Appointment.joins(:time_slot, :patient).select('patient_id AS patient_id, date(app_date) AS app_date, time(from_time) AS from_time, time(to_time) AS to_time').where('time_slots.doctor_id' => @doctor.id).order('app_date DESC')
    #render :text => (@appointments).inspect

    render('doctors/viewDoctorAppointment')
  end

  def search
    @doctor = Doctor.find(User.find(session[:user_id]).doctor_id)
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)

    #entered search parameters
    @date=params[:app][:date]

    if @date.blank? == false
    @appointments=Appointment.joins(:time_slot, :patient)
                      .select('patient_id AS patient_id, date(app_date) AS app_date, time(from_time) AS from_time, time(to_time) AS to_time')
                      .where('time_slots.doctor_id' => @doctor.id)
                      .where('app_date = ?', @date).order('app_date DESC')

    else
      @appointments=Appointment.joins(:time_slot, :patient).select('patient_id AS patient_id, date(app_date) AS app_date, time(from_time) AS from_time, time(to_time) AS to_time').where('time_slots.doctor_id' => @doctor.id).order('app_date DESC')
    end
    render('doctors/viewDoctorAppointment')

   #render :text => (@appointments).inspect

  end


end