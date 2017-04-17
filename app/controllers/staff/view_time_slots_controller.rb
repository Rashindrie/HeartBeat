class Staff::ViewTimeSlotsController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  def show
    @staff = Staff.find((User.find(session[:user_id])).staff_id)
    @doctor_name=Doctor.select(:id, :full_name)
    @doctor_types=DoctorType.sorted

  end

  #searchApp for available appointment timeslots
  def search
    #entered searchApp parameters
    @date=params[:app][:from_date]
    @doctor=params[:app][:doctor_id]
    @app_type=params[:app][:app_type_id]
    @d=params[:app][:d]

    #search params
    @staff = Staff.find((User.find(session[:user_id])).staff_id)
    @doctor_types=DoctorType.sorted
    @doctor_name=Doctor.select(:id, :full_name, :doctor_type_id)

    #searchApp results
    if @d.to_i==0
      @timeslots=TimeSlot.from_doctor(@doctor).order('app_date DESC')
      @appointments=Appointment.group(:time_slot_id).count
      #render :text => (@appointments[3]).inspect
      render('staff/view_time_slots/show')

    elsif @d.to_i==1

      @timeslots=TimeSlot.joins(doctor: :doctor_type).where('doctors.doctor_type_id' => @app_type)
                     .order('app_date DESC')
      @appointments=Appointment.group(:time_slot_id).count
      render('staff/view_time_slots/show')

    elsif @d.to_i==2
      @timeslots=TimeSlot.from_date(@date)
      @appointments=Appointment.group(:time_slot_id).count
      render('staff/view_time_slots/show')
    end
  end

end