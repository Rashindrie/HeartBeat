class Doctor::ViewAppointmentsController < ApplicationController
  layout 'application'
  before_action :confirm_logged_in
  before_action :require_doctor

  def show
    @doctor = Doctor.find(params[:id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
   # @appointments=Appointment.joins(:time_slot, :patient)
                   #   .select('patient_id AS patient_id, patients.first_name AS first_name,patients.last_name AS last_name, date(app_date) AS app_date, time(from_time) AS from_time, time(to_time) AS to_time, (patients.registered) AS registered')
                   #   .where('time_slots.doctor_id' => @doctor.id)
                    #  .where('appointments.status' => 1)
                    #  .order('app_date DESC')
  end


  def searchApp
    @doctor = Doctor.find(params[:id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)

    #entered searchApp parameters
    @date=params[:app][:date]


      @appointments=Appointment.joins(:time_slot, :patient)
                        .select('patient_id AS patient_id, patients.first_name AS first_name,patients.last_name AS last_name, date(app_date) AS app_date, time(from_time) AS from_time, time(to_time) AS to_time, (patients.registered) AS registered')
                        .where('time_slots.doctor_id' => @doctor.id)
                        .where('appointments.status' => 1)
                        .where('app_date = ?', @date)

    if @appointments.blank? == false

    else
      flash.now[:notice] = "You have no appointments for #{@date}"
    end
    render('doctor/view_appointments/show')
  end

end
