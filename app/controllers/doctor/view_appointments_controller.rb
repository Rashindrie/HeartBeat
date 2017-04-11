class Doctor::ViewAppointmentsController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  def show
    @doctor = Doctor.find(User.find(session[:user_id]).doctor_id)
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @appointments=Appointment.joins(:time_slot, :patient).select('patient_id AS patient_id, date(app_date) AS app_date, time(from_time) AS from_time, time(to_time) AS to_time, (registered) AS registered').where('time_slots.doctor_id' => @doctor.id).order('app_date DESC')

    #render :text => (@appointments[1].registered).inspect

  end


  def searchApp
    @doctor = Doctor.find(User.find(session[:user_id]).doctor_id)
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)

    #entered searchApp parameters
    @date=params[:app][:date]

    if @date.blank? == false
      @appointments=Appointment.joins(:time_slot, :patient)
                        .select('patient_id AS patient_id, date(app_date) AS app_date, time(from_time) AS from_time, time(to_time) AS to_time, (registered) AS registered')
                        .where('time_slots.doctor_id' => @doctor.id)
                        .where('app_date = ?', @date)

    else
      @appointments=Appointment.joins(:time_slot, :patient).select('patient_id AS patient_id, date(app_date) AS app_date, time(from_time) AS from_time, time(to_time) AS to_time, (registered) AS registered').where('time_slots.doctor_id' => @doctor.id).order('app_date DESC')
    end
    #render :text => (@appointments).inspect
    render('doctor/view_appointments/show')
  end

end
