class Appointment::SearchAppointmentsController < ApplicationController
  layout 'application'
  #before_filter :require_user
  protect_from_forgery unless: -> { request.format.html? }


  #get appointment timeslots searchApp page

  def searchApp
    @patient = Patient.find((User.find(session[:user_id])).patient_id)
    @doctor_name=Doctor.select(:id, :full_name)
    @doctor_types=DoctorType.sorted
  end



  #add an appointment-registered patient
  def create
    @patient = Patient.find((User.find(session[:user_id])).patient_id)
    @app=Appointment.new

    @app.time_slot_id=TimeSlot.find(params[:id]).id
    @app.patient_id=@patient.id
    @app.registered=1

    if @app.save
      flash[:success] = "Appointement successfully added."
      session[:return_to] ||= request.referer
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "Appointement adding failed. Please try again"
      session[:return_to] ||= request.referer
      redirect_to session.delete(:return_to)
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
    @patient = Patient.find((User.find(session[:user_id])).patient_id)
    @doctor_types=DoctorType.sorted
    @doctor_name=Doctor.select(:id, :full_name, :doctor_type_id)

    #search results
    if @d.to_i==0
      @timeslots=TimeSlot.from_doctor(@doctor).where('app_date >= ?', Date.today)
                     .order('app_date DESC')
      @appointments=Appointment.group(:time_slot_id).count

      #render :text => (@appointments[3]).inspect
      render('appointment/search_appointments/searchApp')

    elsif @d.to_i==1

      @timeslots=TimeSlot.joins(doctor: :doctor_type)
                     .where('doctors.doctor_type_id' => @app_type)
                     .where('app_date >= ?', Date.today)
      @appointments=Appointment.group(:time_slot_id).count
      render('appointment/search_appointments/searchApp')

    elsif @d.to_i==2
      @timeslots=TimeSlot.from_date(@date)
      @appointments=Appointment.group(:time_slot_id).count
      render('appointment/search_appointments/searchApp')
    end
  end

end
