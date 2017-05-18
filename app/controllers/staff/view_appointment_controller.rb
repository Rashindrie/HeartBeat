class Staff::ViewAppointmentController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }
  before_action :confirm_logged_in
  before_action :require_staff

  def index
    @staff = Staff.find(params[:id])
    @doctors = Doctor.all.select('id AS id').select('full_name AS full_name').to_json
    @doctor_types=DoctorType.sorted
  end

  def search
    #entered searchApp parameters

    @doctor=params[:doctor_id]
    @doctors = Doctor.all.select('id AS id').select('full_name AS full_name').to_json

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


  def print
    @staff = Staff.find(params[:staff_id])
    @doctor=Doctor.find(params[:doctor_id])
    @appointments=Appointment.joins(:time_slot, :patient)
                      .select('appointments.id AS app_id, patient_id AS patient_id, patients.first_name AS first_name,patients.last_name AS last_name, date(app_date) AS app_date, time(from_time) AS from_time, time(to_time) AS to_time, (patients.registered) AS registered')
                      .where('time_slots.doctor_id' => @doctor.id)

    if Rails.env.development?
      #render template: "staff/view_appointment/print"
      require "pdfkit"
      html=render_to_string(:action=>"print")
      @kit  = PDFKit.new(html, page_size: 'A4')
      @kit.to_file("appointment.pdf")
      send_data @kit.to_pdf,  :filename => "Appointment Details:#{@doctor.id}.pdf",
                :type => "application/pdf",
                :disposition  => "attachment"  #change to "attachment" later to force download
    else
      require "pdfkit"
      html=render_to_string(:action=>"print")
      @kit  = PDFKit.new(html, page_size: 'A4')
      @kit.to_file("appointment.pdf")
      send_data @kit.to_pdf,  :filename => "Appointment Details:#{@doctor.id}.pdf",
                :type => "application/pdf",
                :disposition  => "attachment"  #change to "attachment" later to force download
    end
  end



end
