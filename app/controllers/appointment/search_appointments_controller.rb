class Appointment::SearchAppointmentsController < ApplicationController
  layout 'patient'
  #before_filter :require_user
  protect_from_forgery unless: -> { request.format.html? }

  def show
    @patient = Patient.find((User.find(session[:user_id])).patient_id)
    @doctor_name=Doctor.select(:id, :full_name)
    @doctor_types=DoctorType.sorted

    render('appointments/searchAppointment')
  end

  def create
    @patient = Patient.find((User.find(session[:user_id])).patient_id)
    @app=Appointment.new

    @app.time_slot_id=TimeSlot.find(params[:id]).id
    @app.patient_id=@patient.id

    if @app.save
      flash.now[:notice] = "Appointement successfully added."
      session[:return_to] ||= request.referer
      redirect_to session.delete(:return_to)
    else
      flash.now[:notice] = "Appointement adding failed. Please try again"
      session[:return_to] ||= request.referer
      redirect_to session.delete(:return_to)
    end

  end

  def addWaitingList

  end

  def search
    #entered search parameters
    @date=params[:app][:from_date]
    @doctor=params[:app][:doctor_id]
    @app_type=params[:app][:app_type_id]
    @d=params[:app][:d]

    #search params
    @patient = Patient.find((User.find(session[:user_id])).patient_id)
    @doctor_types=DoctorType.sorted
    @doctor_name=Doctor.select(:id, :full_name, :doctor_type_id)

    #appointment/waitingList


    #search results
    if @d.to_i==0
        @timeslots=TimeSlot.fromdoctor(@doctor)
        @appointments=Appointment.group(:time_slot_id).count

        #render :text => (@appointments[3]).inspect
        render('appointments/searchAppointment')

    elsif @d.to_i==1

      @timeslots=TimeSlot.joins(doctor: :doctor_type).where('doctors.doctor_type_id' => @app_type).where('app_date >= ?', Date.today)
      @appointments=Appointment.group(:time_slot_id).count
      render('appointments/searchAppointment')

    elsif @d.to_i==2
      @timeslots=TimeSlot.fromdate(@date)
      @appointments=Appointment.group(:time_slot_id).count
      render('appointments/searchAppointment')


    end

    #render :text => (@timeslots).inspect

  end






end
