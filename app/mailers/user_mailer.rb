class UserMailer < ApplicationMailer
  default from: 'support@heartbeat.com'

  def notify_cancel(user,app_id)
    @user = user
    @app=Appointment.find(app_id)
    @timeslot=TimeSlot.find(@app.time_slot_id)
    @doctor=Doctor.find(@timeslot.doctor_id)
    @url  = "http://localhost:3000/appointment/search/#{@user.id}"


    email_with_name = %("#{@user.first_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "HeartBeat: Appointment on #{@timeslot.app_date} Cancelled")
  end

  def notify_cancel_doctor(staff,timeslot)
    @staff = staff
    @timeslot=timeslot
    @a=Doctor.find(@timeslot.doctor_id)
    @user=Doctor.find(@timeslot.doctor_id)
    @url  = "http://localhost:3000"


    email_with_name = %("#{@user.first_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "HeartBeat: Appointment on #{@timeslot.app_date} Cancelled")
  end

  def appointment_cancelled(user,app_id)
    @a = user
    @user = User.find_by_patient_id(user.id)
    @app=Appointment.find(app_id)
    @timeslot=TimeSlot.find(@app.time_slot_id)
    @doctor=Doctor.find(@timeslot.doctor_id)
    @url  = "http://localhost:3000/appointment/#{@user.id}/#{@app.id}"

    email_with_name = %("#{@a.first_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "HeartBeat: Appointment on #{@timeslot.app_date} Cancelled")
  end

  def waiting_list(user,time_slot_id)
    @a = user
    @user=User.find_by_patient_id(user.id)
    @timeslot=TimeSlot.find(time_slot_id)
    @doctor=Doctor.find(@timeslot.doctor_id)
    @url  = "http://localhost:3000/appointment/search/#{@user.id}"

    email_with_name = %("#{@a.first_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "HeartBeat: 1 free slot on #{@timeslot.app_date}")
  end

  def password_reset(user)
    @user = user
    @a = (Patient.find(user.patient_id)) || (Doctor.find(user.doctor_id)) || (Staff.find(user.staff_id))
    email_with_name = %("#{@a.first_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "HeartBeat: Reset your password")
  end

  def account_activation(user)
    @user = user
    @a = (Patient.find(user.patient_id)) || (Doctor.find(user.doctor_id)) || (Staff.find(user.staff_id))
    email_with_name = %("#{@a.first_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "HeartBeat: Account Activation")
  end

end
