class VisitsController < ApplicationController

  layout 'application'

  before_action :confirm_logged_in
  before_action :require_user

  def new
    @doctor =Doctor.find(params[:doctor_id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, gender AS gender, telephone AS telephone, date_of_birth AS date_of_birth, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:id]).first
    @age=age(@patient.date_of_birth)

    @visit=Visit.new
  end

  def create
    @visit=Visit.new(visit_params)
    @visit.patient_id=params[:id]
    @visit.doctor_id=params[:doctor_id]

    if @visit.valid?
      @visit.save
      flash[:success] = "Visit added successfully."
      redirect_to :controller => 'visits', :action => 'index', :doctor_id => params[:doctor_id], :id => params[:id]
    else
      flash.now[:error] = "Action unsuccessful. Please try again."
      @id = params[:id]
      @doctor =Doctor.find(params[:doctor_id])
      @doctor_type = DoctorType.find(@doctor.doctor_type_id)
      @patient = Patient.joins(:user)
                     .select('patients.id AS id, gender AS gender, telephone AS telephone, date_of_birth AS date_of_birth, first_name AS first_name,last_name AS last_name, users.email AS email')
                     .where('patient_id = ?',params[:id]).first
      @age=age(@patient.date_of_birth)
      render('/visits/new')

    end

  end

  #get patients visits
  def index
    if current_user.doctor?
      @doctor =Doctor.find(params[:doctor_id])
      @doctor_type = DoctorType.find(@doctor.doctor_type_id)
      @patient = Patient.joins(:user)
                     .select('patients.id AS id, gender AS gender, telephone AS telephone, date_of_birth AS date_of_birth, first_name AS first_name,last_name AS last_name, users.email AS email')
                     .where('patient_id = ?',params[:id]).first
      @age=age(@patient.date_of_birth)
    else
      @patient = Patient.joins(:user)
                     .select('patients.id AS id, date_of_birth AS date_of_birth, first_name AS first_name,last_name AS last_name, users.email AS email')
                     .where('patient_id = ?',params[:id]).first
      @age=age(@patient.date_of_birth)
    end

    @doctors=Doctor.select(:id, :first_name, :last_name)
    @visits = Visit.where('patient_id = ?', params[:id]).order("created_at DESC")
    @count=Visit.where('patient_id = ?', params[:id]).count
    #render :text => (@count).inspect


  end




  #private method
  private
  def visit_params
    params.require(:visit).permit(:problems_complaints, :diagnosis, :drugs, :remarks )
  end

  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end
