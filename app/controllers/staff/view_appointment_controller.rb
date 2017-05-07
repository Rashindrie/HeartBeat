class Staff::ViewAppointmentController < ApplicationController
  layout 'application'
  protect_from_forgery
  def index
    @staff = Staff.find(params[:id])
    @doctors=Doctor.pluck(:full_name, :id)
    @doctor_types=DoctorType.sorted
  end

  def search
    #entered searchApp parameters

    @doctor=params[:app][:doctor_id]

    #search params
    @staff = Staff.find(params[:id])
    @doctor_types=DoctorType.sorted
    @doctor_name=Doctor.select(:id, :full_name, :doctor_type_id)
    @name=Doctor.find(@doctor).full_name

    #search results
    @appointments=Appointment.joins(:time_slot, :patient)
                      .select('appointments.id AS app_id, patient_id AS patient_id, patients.first_name AS first_name,patients.last_name AS last_name, date(app_date) AS app_date, time(from_time) AS from_time, time(to_time) AS to_time, (patients.registered) AS registered')
                      .where('time_slots.doctor_id' => @doctor)



      if @appointments.blank?
        flash.now[:notice]="No records found for Dr.#{@name}"
        return render('staff/view_appointment/index')
      else
        return render('staff/view_appointment/index')
      end



  end

end
