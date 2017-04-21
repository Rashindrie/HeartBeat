class Appointment::SearchAppointmentsController < ApplicationController
  layout 'application'
  #before_filter :require_user
  protect_from_forgery unless: -> { request.format.html? }


  #get appointment timeslots searchApp page

  def searchApp
    @patient = Patient.find(params[:id])
    @doctor_name=Doctor.select(:id, :full_name)
    @doctor_types=DoctorType.sorted
  end



  #add an appointment-registered patient
  def create
    @patient = Patient.find(params[:patient_id])
    @doctor_name=Doctor.select(:id, :full_name)
    @doctor_types=DoctorType.sorted

    @app=Appointment.new
    @time_slot=TimeSlot.find(params[:id])
    @app.time_slot_id=@time_slot.id
    @app.patient_id=@patient.id
    @app.registered=1
    @app.status=1

    #@appointments=Appointment.where('status = ?', 1).group(:time_slot_id).count
    if ((@time_slot.to_time - @time_slot.from_time)/15.minutes).to_i > Appointment.where('time_slot_id = ?', @time_slot.id).where('status = ?', 1).count
      if @app.valid?
        @app.save
        flash[:success] = "Appointement successfully added."
        redirect_to :controller => 'patient/view_appointments', :action => 'show', patient_id: @patient.id, id: @app.id
      else
        flash.now[:error] = "Appointement adding failed. Please try again"
        render('appointment/search_appointments/searchApp')
        end
    else
        flash[:error] = "Appointement adding failed. Please try again"
        session[:return_to] ||= request.referer
        redirect_to session.delete(:return_to)
    end

  end

  # add to waiting list - registered patient
  def add
    @patient = Patient.find(params[:patient_id])
    @doctor_name=Doctor.select(:id, :full_name)
    @doctor_types=DoctorType.sorted

    @app=WaitingList.new
    @app.time_slot_id=TimeSlot.find(params[:id]).id
    @app.patient_id=@patient.id
    @app.registered=true

    if @app.valid?
      @app.save
      flash[:success] = "Successfully added to waiting list."
      session[:return_to] ||= request.referer
      redirect_to session.delete(:return_to)
    else
      flash.now[:error] = "Adding to waiting list failed. Please try again"
      render('appointment/search_appointments/searchApp')
    end
  end

  #search for available appointment timeslots
  def search
    #entered searchApp parameters
    @date=params[:app][:from_date]
    @doctor=params[:app][:doctor_id]
    @app_type=params[:app][:app_type_id]
    @d=params[:app][:d]

    #search params
    @patient = Patient.find(params[:id])
    @doctor_types=DoctorType.sorted
    @doctor_name=Doctor.select(:id, :full_name, :doctor_type_id)
    @existing_app = Appointment.where('patient_id = ?', @patient.id).where('status = ?', 1).pluck(:time_slot_id)


    #search results
    if @d.to_i==0
      @timeslots=TimeSlot.from_doctor(@doctor).where('app_date >= ?', Date.today).where('status = ?',1)
                     .order('app_date DESC')
      @appointments=Appointment.where('status = ?', 1).group(:time_slot_id).count
      render('appointment/search_appointments/searchApp')

    elsif @d.to_i==1

      @timeslots=TimeSlot.joins(doctor: :doctor_type)
                     .where('doctors.doctor_type_id' => @app_type)
                     .where('app_date >= ?', Date.today).where('status = ?',1)
      @appointments=Appointment.where('status = ?', 1).group(:time_slot_id).count
      render('appointment/search_appointments/searchApp')

    elsif @d.to_i==2
      @timeslots=TimeSlot.from_date(@date).where('status = ?',1)
      @appointments=Appointment.where('status = ?', 1).group(:time_slot_id).count
      render('appointment/search_appointments/searchApp')
    end
  end

end
