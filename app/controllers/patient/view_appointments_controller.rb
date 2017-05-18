class Patient::ViewAppointmentsController < ApplicationController
  layout 'application'

  #validate authorized user
  before_action :confirm_logged_in
  before_action :require_patient

  #rende rpage to show appointment summary
  def index
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:id]).first

    @appointments=Appointment.joins(time_slot: :doctor )
                      .select('appointments.id AS app_id, appointments.status AS status, first_name AS first_name,last_name AS last_name, date(app_date) AS app_date, time(from_time) AS from_time, time(to_time) AS to_time')
                      .where('appointments.patient_id' => @patient.id)
                      .order('app_date DESC')

    if @appointments.blank?
      flash.now[:notice] = "No Schedueld Appointments"
      end
  end

  #show patient summary per appointment
  def show
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:patient_id]).first

    @appointments=Appointment.joins(time_slot: :doctor )
                      .select('appointments.id AS app_id, appointments.status AS status, first_name AS first_name,last_name AS last_name, date(app_date) AS app_date, time(from_time) AS from_time, time(to_time) AS to_time')
                      .where('appointments.id' => params[:id])

    #render :text => (@appointments).inspect
  end

  def update
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, full_name AS full_name, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:patient_id]).first
    @app=Appointment.find(params[:id])

    @app.status=0

    if @app.save
      UserMailer.appointment_cancelled(@patient, @app.id).deliver_now
      flash[:success] = "Appointment cancelled successfully"

      #notify waitinglist patients
      @time_slot_id=@app.time_slot_id
      @wl=WaitingList.where('time_slot_id = ?', @time_slot_id)
      if !@wl.blank?
        @wl.each do |d|
          @user=Patient.joins(:user)
                    .select('patients.id AS id, full_name AS full_name, first_name AS first_name,last_name AS last_name, users.email AS email')
                    .where('patient_id = ?',d.patient_id).first
          UserMailer.waiting_list(@user, @time_slot_id).deliver_now
        end
      end

     redirect_to :controller => 'patient/view_appointments', :action => 'show', patient_id: @patient.id, id: @app.id

    else
      flash[:error] = "Appointment cancellation unsuccessful. Please try again"
      redirect_to :controller => 'patient/view_appointments', :action => 'show', patient_id: @patient.id, id: @app.id
      #render('/patient/profile/<%= @patient.id %>')  #to get a prepolutaed form
    end
  end


end
