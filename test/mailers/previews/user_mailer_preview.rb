
class UserMailerPreview < ActionMailer::Preview

  def notify_cancel
    UserMailer.notify_cancel(@patient = Patient.joins(:user).select('patients.id AS id, first_name AS first_name,full_name AS full_name, users.email AS email').where('patient_id = ?',1).first,Appointment.first.id)
  end

  def notify_cancel_doctor
    UserMailer.notify_cancel_doctor(Staff.first,TimeSlot.first)
  end

  def appointment_cancelled
    UserMailer.appointment_cancelled(@patient = Patient.joins(:user).select('patients.id AS id, first_name AS first_name,full_name AS full_name, users.email AS email').where('patient_id = ?',2).first,40)
  end

  def waiting_list
    UserMailer.waiting_list(@patient = Patient.joins(:user).select('patients.id AS id, first_name AS first_name,full_name AS full_name, users.email AS email').where('patient_id = ?',2).first,12)
  end

  def account_activation
    user = User.find(12)
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end
end