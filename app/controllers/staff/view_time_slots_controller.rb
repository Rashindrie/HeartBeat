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
    @staff = Staff.find(params[:id])
    @doctor_types=DoctorType.sorted
    @doctor_name=Doctor.select(:id, :full_name, :doctor_type_id)

    #search results
    if @d.to_i==-1
      @timeslots=TimeSlot.from_date(Date.today)
      @appointments=Appointment.group(:time_slot_id).count

      if @timeslots.blank?
        flash.now[:notice]="No records found for #{Date.today}"
        return render('staff/view_time_slots/show')
      else
        return render('staff/view_time_slots/show')
      end

    elsif @d.to_i==0
      @timeslots=TimeSlot.from_doctor(@doctor).order('app_date DESC')
      @appointments=Appointment.group(:time_slot_id).count


      if @timeslots.blank?
        flash.now[:notice]="No records found for Doctor #{Doctor.find(@doctor).full_name}"
        return render('staff/view_time_slots/show')
      else
        return render('staff/view_time_slots/show')
      end

    elsif @d.to_i==1

      @timeslots=TimeSlot.joins(doctor: :doctor_type).where('doctors.doctor_type_id' => @app_type)
                     .order('app_date DESC')
      @appointments=Appointment.group(:time_slot_id).count

      if @timeslots.blank?
        flash.now[:notice]="No records found for Appointment Type - #{DoctorType.find(@app_type).speciality}"
        return render('staff/view_time_slots/show')
      else
        return render('staff/view_time_slots/show')
      end

    elsif @d.to_i==2
      @timeslots=TimeSlot.from_date(@date)
      @appointments=Appointment.group(:time_slot_id).count

      if @timeslots.blank?
        flash.now[:notice]="No records found for #{@date}"
        return render('staff/view_time_slots/show')
      else
        return render('staff/view_time_slots/show')
      end

    end
  end

  def update
    @staff = Staff.find(params[:id])
    @timeslot=TimeSlot.find(params[:timeslot][:id])

    if @timeslot.update_attribute(:status,false)
      @timeslot.update_attribute(:staff_id, @staff.id)
      #send email
      @appointments=Appointment.joins(:time_slot, :patient)
                        .select('appointments.id AS app_id, appointments.status AS status, appointments.patient_id AS patient_id , patients.email AS email')
                        .where('appointments.status' => 1)
                        .where('time_slots.id' => params[:timeslot][:id])

      #send email notifications
      @appointments.each do |app|
          app.update_attribute(:status, false)
          @user=Patient.find(app.patient_id)
          UserMailer.notify_cancel(@user).deliver_now
      end

      flash[:success] = "Time slot updated successfully"
      redirect_to controller: '/staff/view_time_slots', action: 'show', :id => @staff.id
    else
      flash[:notice] = "Error occurred in updating time slot. Please try again."
      redirect_to controller: '/staff/view_time_slots', action: 'show', :id => @staff.id
    end

  end
end
