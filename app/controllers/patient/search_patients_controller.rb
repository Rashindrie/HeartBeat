class Patient::SearchPatientsController < ApplicationController
  layout 'application'

  before_action :confirm_logged_in
  before_action :require_doctor

  def index
    @doctor = Doctor.find(User.find(session[:user_id]).doctor_id)
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @patients=Patient.select('id AS id').select('full_name AS full_name').where('registered = 1').to_json

  end

  def show
    @doctor = Doctor.find(params[:doctor_id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, date_of_birth AS date_of_birth, gender AS gender, telephone AS telephone, date_of_birth AS date_of_birth, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:id]).first
    @age=age(@patient.date_of_birth)

    #for vital summary chart of patient
    @data=Vital.where(:patient_id => @patient.id)
    @bld_pr= @data.pluck(:bld_pressure)
    @temp= @data.pluck(:temp)
    @pulse= @data.pluck(:pulse)
    @res_rate= @data.pluck(:res_rate)
    @from_date= @data.order('created_at').pluck(:created_at).first
    @to_date= @data.order('created_at DESC').pluck(:created_at).first
    @array = @bld_pr.each_with_index.map { |x,i| [ i+1, x, @temp[i], @pulse[i], @res_rate[i]] }

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
