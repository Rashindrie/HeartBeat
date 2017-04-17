class Patient::ViewAppointmentsController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  def index
    @patient = Patient.find(params[:id])

    @appointments=Appointment.joins(time_slot: :doctor )
                      .select('appointments.id AS app_id, status AS status, first_name AS first_name,last_name AS last_name, date(app_date) AS app_date, time(from_time) AS from_time, time(to_time) AS to_time')
                      .where('appointments.patient_id' => @patient.id)
                      .order('app_date DESC')
  end

  def show
    @patient = Patient.find(params[:patient_id])

    @appointments=Appointment.joins(time_slot: :doctor )
                      .select('appointments.id AS app_id, status AS status, first_name AS first_name,last_name AS last_name, date(app_date) AS app_date, time(from_time) AS from_time, time(to_time) AS to_time')
                      .where('appointments.id' => params[:id])

    #render :text => (@appointments).inspect
  end

  def update
    @patient = Patient.find(params[:patient_id])
    @app=Appointment.find(params[:id])

    @app.status=0

    if @app.save
      flash[:success] = "Appointment cancelled successfully"

      #adding an appointment to a waitinglist patient

      #@time_slot_id=Appointment.joins(:time_slot).where('appointments.id' => @app.id).pluck(:time_slot_id)
      #@wl_patient_id=WaitingList.where('time_slot_id = ?', @time_slot_id).order('created_at DESC').limit(1).pluck(:patient_id)
      #@wl=WaitingList.where('time_slot_id = ?', @time_slot_id).order('created_at DESC').limit(1).pluck(:id)
      #WaitingList.destroy(@wl)
      #@new_app=Appointment.new
      #@new_app.patient_id= @wl_patient_id
      #@new_app.time_slot_id= @time_slot_id
      #@new_app.save!

      redirect_to :controller => 'patient/view_appointments', :action => 'show', patient_id: @patient.id, id: @app.id

    else
      flash[:notice] = "Appointment cancellation unsuccessful. Please try again"
      redirect_to :controller => 'patient/view_appointments', :action => 'show', patient_id: @patient.id, id: @app.id
      #render('/patient/profile/<%= @patient.id %>')  #to get a prepolutaed form
    end
  end


end
