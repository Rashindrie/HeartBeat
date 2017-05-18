class Appointment::SearchAppointmentsController < ApplicationController
  layout 'application'
  #before_filter :require_user
  protect_from_forgery unless: -> { request.format.html? }

  before_action :confirm_logged_in
  before_action :require_patient


  #get appointment timeslots searchApp page

  def searchApp
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, date_of_birth AS date_of_birth, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:id]).first
    @doctor_name=Doctor.select(:id, :full_name)
    @doctor_types=DoctorType.sorted

  end


  #add an appointment-registered patient
  def create
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, date_of_birth AS date_of_birth, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:patient_id]).first
    @doctor_name=Doctor.select(:id, :full_name)
    @doctor_types=DoctorType.sorted

    @app=Appointment.new
    @time_slot=TimeSlot.find(params[:id])
    @app.time_slot_id=@time_slot.id
    @app.patient_id=@patient.id
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
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, date_of_birth AS date_of_birth, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:patient_id]).first
    @doctor_name=Doctor.select(:id, :full_name)
    @doctor_types=DoctorType.sorted

    @app=WaitingList.new
    @app.time_slot_id=TimeSlot.find(params[:id]).id
    @app.patient_id=@patient.id

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
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, date_of_birth AS date_of_birth, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:id]).first
    @doctor_types=DoctorType.sorted
    @doctor_name=Doctor.select(:id, :full_name, :doctor_type_id)
    @existing_app = Appointment.where('patient_id = ?', @patient.id).where('status = ?', 1).pluck(:time_slot_id)


    #search results
    if @d.to_i==-1
      @name=Date.today.to_date
      @timeslots=TimeSlot.from_doctor(@doctor).where('app_date = ?', Date.today).where('status = ?',1)
                     .order('app_date DESC')
      @appointments=Appointment.where('status = ?', 1).group(:time_slot_id).count

      if @timeslots.blank?
        flash.now[:notice]="No records found for #{Date.today}"
        return render('appointment/search_appointments/searchApp')
      else
        return render('appointment/search_appointments/searchApp')
      end

    elsif @d.to_i==0
      @name=Doctor.find(@doctor).full_name
      @timeslots=TimeSlot.from_doctor(@doctor).where('app_date >= ?', Date.today).where('status = ?',1)
                     .order('app_date DESC')
      @appointments=Appointment.where('status = ?', 1).group(:time_slot_id).count

      if @timeslots.blank?
        flash.now[:notice]="No records found for Doctor #{Doctor.find(@doctor).full_name}"
        return render('appointment/search_appointments/searchApp')
      else
        return render('appointment/search_appointments/searchApp')
      end

    elsif @d.to_i==1
      @name=DoctorType.find(@app_type).speciality
      @timeslots=TimeSlot.joins(doctor: :doctor_type)
                     .where('doctors.doctor_type_id' => @app_type)
                     .where('app_date >= ?', Date.today).where('status = ?',1)
      @appointments=Appointment.where('status = ?', 1).group(:time_slot_id).count

      if @timeslots.blank?
        flash.now[:notice]="No records found for Appointment Type - #{DoctorType.find(@app_type).speciality}"
        return render('appointment/search_appointments/searchApp')
      else
        return render('appointment/search_appointments/searchApp')
      end

    elsif @d.to_i==2
      @name=@date
      @timeslots=TimeSlot.from_date(@date).where('status = ?',1)
      @appointments=Appointment.where('status = ?', 1).group(:time_slot_id).count

      if @timeslots.blank?
        flash.now[:notice]="No records found for #{@date}"
        return render('appointment/search_appointments/searchApp')
      else
        return render('appointment/search_appointments/searchApp')
      end
    end
  end

end
