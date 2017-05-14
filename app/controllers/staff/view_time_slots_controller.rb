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
      @name=Date.today.to_date
      if @timeslots.blank?
        flash.now[:notice]="No records found for #{Date.today}"
        return render('staff/view_time_slots/show')
      else
        return render('staff/view_time_slots/show')
      end

    elsif @d.to_i==0
      @name=Doctor.find(@doctor).full_name
      @timeslots=TimeSlot.from_doctor(@doctor).order('app_date DESC')
      @appointments=Appointment.group(:time_slot_id).count


      if @timeslots.blank?
        flash.now[:notice]="No records found for Doctor #{Doctor.find(@doctor).full_name}"
        return render('staff/view_time_slots/show')
      else
        return render('staff/view_time_slots/show')
      end

    elsif @d.to_i==1
      @name=DoctorType.find(@app_type).speciality
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
      @name=@date
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
      UserMailer.notify_cancel_doctor(@staff,@timeslot).deliver_now
      @appointments=Appointment.joins(:time_slot, :patient).select('time_slot_id AS time_slot_id, appointments.id AS id, appointments.status AS status,patients.registered AS registered, appointments.patient_id AS patient_id').where('appointments.status' => 1).where('time_slots.id' => params[:timeslot][:id])

      #send email notifications
      @appointments.each do |app|
          @a=app
          @a.status=0
          if @a.save
            @patient=Patient.find(app.patient_id)
            if @patient.registered
              @user = Patient.joins(:user)
                          .select('patients.id AS id, patients.registered AS registered, full_name AS full_name, first_name AS first_name,last_name AS last_name, users.email AS email,patients.registered AS registered')
                          .where('patients.id = ?',app.patient_id).first

              UserMailer.notify_cancel(@user,app.app_id).deliver_now
              end
          end
      end

      flash[:success] = "Time slot cancelled successfully"
      redirect_to controller: '/staff/view_time_slots', action: 'show', :id => @staff.id
    else
      flash[:notice] = "Error occurred in cancelling time slot. Please try again."
      redirect_to controller: '/staff/view_time_slots', action: 'show', :id => @staff.id
    end

  end
end
