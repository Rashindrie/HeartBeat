class VisitsController < ApplicationController

  layout 'application'

  protect_from_forgery unless: -> { request.format.html? }

  def new
    @doctor =Doctor.find(params[:doctor_id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @patient = Patient.find(params[:id])
    @age=age(@patient.date_of_birth)

    @visit=Visit.new
  end

  def create
    @visit=Visit.new(visit_params)
    @visit.patient_id=params[:id]
    @visit.doctor_id=params[:doctor_id]

    if @visit.valid?
      @vital.save
      flash[:success] = "Visit added successfully."
      redirect_to :controller => 'visits', :action => 'index', :doctor_id => params[:doctor_id], :id => params[:id]
    else
      flash.now[:error] = "Action unsuccessful. Please try again."
      @id = params[:id]
      @doctor =Doctor.find(params[:doctor_id])
      @doctor_type = DoctorType.find(@doctor.doctor_type_id)
      @patient = Patient.find(params[:id])
      @age=age(@patient.date_of_birth)
      render('/visits/new')

    end

  end

  #get patients visits
  def index
    if current_user.doctor?
      @doctor =Doctor.find(params[:doctor_id])
      @doctor_type = DoctorType.find(@doctor.doctor_type_id)
      @patient = Patient.find(params[:id])
      @age=age(@patient.date_of_birth)
    else
      @patient = Patient.find(params[:id])
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
