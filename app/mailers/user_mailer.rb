class UserMailer < ApplicationMailer
  default from: 'support@heartbeat.com'

  def notify_cancel(user)
    @user = user
    @app=Appointment.select('appointments.time_slot_id AS time_slot_id').where('patient_id =?', @user.id).order('updated_at DESC').limit(1)
    @timeslot=TimeSlot.find(@app[0].time_slot_id)
    @doctor=Doctor.find(@timeslot.doctor_id)
    @url  = 'http://localhost:3000/login'


    email_with_name = %("#{@user.first_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "HeartBeat: Appointment on #{@timeslot.app_date} Cancelled")
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
