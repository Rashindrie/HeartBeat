class Patient::SearchPatientsController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  def index
    @doctor = Doctor.find(User.find(session[:user_id]).doctor_id)
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @patients=Patient.where('registered = 1').pluck(:full_name, :id)
    @patientsAll=Patient.where('registered = 1').order('full_name')
  end

  def show
    @doctor = Doctor.find(params[:doctor_id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, date_of_birth AS date_of_birth, gender AS gender, telephone AS telephone, date_of_birth AS date_of_birth, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:id]).first
    @age=age(@patient.date_of_birth)
  end


  def search
    @doctor = Doctor.find(params[:id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, date_of_birth AS date_of_birth, gender AS gender, telephone AS telephone, date_of_birth AS date_of_birth, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:search][:patient_id]).first
    @age=age(@patient.date_of_birth)
    render('patient/search_patients/show')
  end

  private
  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end
