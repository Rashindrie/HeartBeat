class Patient::SearchPatientsController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  respond_to :html, :json

  def index
    @doctor = Doctor.find(User.find(session[:user_id]).doctor_id)
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)

    #@patients=Patient.all
    respond_to do |format|
      format.html
      format.json do
        render json: PatientDatatable.new(view_context)
      end
    end
  end


  def show
    @doctor = Doctor.find(params[:doctor_id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @patient = Patient.find(params[:id])
    @age=age(@patient.date_of_birth)
  end


  private
  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end
