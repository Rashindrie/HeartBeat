class Staff::AddAppointmentController < ApplicationController

  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }
  before_action :confirm_logged_in
  before_action :require_staff

  def index
    @staff = Staff.find(params[:id])
    @doctor_name=Doctor.select(:id, :full_name)
    @doctor_types=DoctorType.sorted
  end

  def search
    #entered searchApp parameters
    @date=params[:app][:from_date]
    @doctor=params[:app][:doctor_id]
    @app_type=params[:app][:app_type_id]
    @d=params[:app][:d]

    #search params
    @staff = Staff.find(params[:id])
    @doctor_types=DoctorType.sorted
    @doctor_name=Doctor.select(:id, :full_name, :doctor_type_id)

    #search results
    if @d.to_i==-1
      @name=Date.today.to_date
      @timeslots=TimeSlot.from_doctor(@doctor).where('app_date = ?', Date.today).where('status = ?',1)
                     .order('app_date DESC')
      @appointments=Appointment.where('status = ?', 1).group(:time_slot_id).count

      if @timeslots.blank?
        flash.now[:notice]="No records found for #{Date.today}"
        return render('staff/add_appointment/index')
      else
        return render('staff/add_appointment/index')
      end

    elsif @d.to_i==0
      @name=Doctor.find(@doctor).full_name
      @timeslots=TimeSlot.from_doctor(@doctor).where('app_date >= ?', Date.today).where('status = ?',1)
                     .order('app_date DESC')
      @appointments=Appointment.where('status = ?', 1).group(:time_slot_id).count

      if @timeslots.blank?
        flash.now[:notice]="No records found for Doctor #{Doctor.find(@doctor).full_name}"
        return render('staff/add_appointment/index')
      else
        return render('staff/add_appointment/index')
      end

    elsif @d.to_i==1
      @name=DoctorType.find(@app_type).speciality
      @name=Doctor.find(@doctor).full_name
      @timeslots=TimeSlot.joins(doctor: :doctor_type)
                     .where('doctors.doctor_type_id' => @app_type)
                     .where('app_date >= ?', Date.today).where('status = ?',1)
      @appointments=Appointment.where('status = ?', 1).group(:time_slot_id).count

      if @timeslots.blank?
        flash.now[:notice]="No records found for Appointment Type - #{DoctorType.find(@app_type).speciality}"
        return render('staff/add_appointment/index')
      else
        return render('staff/add_appointment/index')
      end

    elsif @d.to_i==2
      @name=@date
      @timeslots=TimeSlot.from_date(@date).where('status = ?',1)
      @appointments=Appointment.where('status = ?', 1).group(:time_slot_id).count

      if @timeslots.blank?
        flash.now[:notice]="No records found for #{@date}"
        return render('staff/add_appointment/index')
      else
        return render('staff/add_appointment/index')
      end
    end
  end

  def show
    @staff = Staff.find(params[:staff_id])
    @timeslot = TimeSlot.find(params[:id])
    @doctor=Doctor.find(@timeslot.doctor_id)
    @doctor_type=DoctorType.find(@doctor.doctor_type_id).speciality
    @patients = Patient.all.select('id AS id').select('full_name AS full_name').to_json
  end

  def create
    @staff = Staff.find(params[:id])
    @patients = Patient.all.select('id AS id').select('full_name AS full_name').to_json

    @doctor=Doctor.find(params[:app][:doctor_id])
    @doctor_type=DoctorType.find(@doctor.doctor_type_id).speciality
    @timeslot=TimeSlot.find(params[:app][:id])

    @app=Appointment.new
    @app.time_slot_id=params[:app][:id]
    @app.patient_id=params[:app][:patient_id]
    @app.status=1

    #@appointments=Appointment.where('status = ?', 1).group(:time_slot_id).count
    if ((@timeslot.to_time - @timeslot.from_time)/15.minutes).to_i > Appointment.where('time_slot_id = ?', @timeslot.id).where('status = ?', 1).count
      if @app.valid?
        @app.save
        flash[:success] = "Appointement successfully added."
        redirect_to :controller => 'staff/add_appointment', :action => 'summary', staff_id: @staff.id, patient_id: @app.patient_id, id: @app.id
      else
        flash.now[:error] = "Appointement adding failed. Please try again"
        render('staff/add_appointment/show')
      end
    else
      flash.now[:error] = "Appointement adding failed. Slot fully booked."
      render('staff/add_appointment/show')
    end

    end

  def summary
    @staff = Staff.find(params[:staff_id])

    @patient = Patient.select('first_name AS first_name,last_name AS last_name')
                   .where('id = ?',params[:patient_id]).first
    @app=Appointment.find(params[:id])
    @timeslot=TimeSlot.find(@app.time_slot_id)
    @doctor=Doctor.find(@timeslot.doctor_id)
    @doctor_type=DoctorType.find(@doctor.doctor_type_id).speciality

    render('staff/add_appointment/summary')
  end

  def print
    @staff = Staff.find(params[:staff_id])
    @patient = Patient.select('first_name AS first_name,last_name AS last_name')
                   .where('id = ?',params[:patient_id]).first
    @app=Appointment.find(params[:id])
    @timeslot=TimeSlot.find(@app.time_slot_id)
    @doctor=Doctor.find(@timeslot.doctor_id)
    @doctor_type=DoctorType.find(@doctor.doctor_type_id).speciality

    if Rails.env.development?
      #render template: "staff/add_appointment/print"
      require "pdfkit"
      html=render_to_string(:action=>"print")
      @kit  = PDFKit.new(html, page_size: 'A4')
      @kit.to_file("payment.pdf")
      send_data @kit.to_pdf,  :filename => "Payment Details:#{@app.id}.pdf",
                :type => "application/pdf",
                :disposition  => "attachment"  #change to "attachment" later to force download
    else
        require "pdfkit"
        html=render_to_string(:action=>"print")
        @kit  = PDFKit.new(html, page_size: 'A4')
        @kit.to_file("payment.pdf")
        send_data @kit.to_pdf,  :filename => "Payment Details:#{@app.id}.pdf",
                                :type => "application/pdf",
                                :disposition  => "attachment"  #change to "attachment" later to force download
    end
  end


  private
  def render_sample_html
    render template: "staff/add_appointment/print"
  end


end



