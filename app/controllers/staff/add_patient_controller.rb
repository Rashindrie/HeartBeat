class Staff::AddPatientController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }
  before_action :confirm_logged_in
  before_action :require_staff

  def new
    @staff = Staff.find(params[:id])
  end

  def create
    @staff = Staff.find(params[:id])

    #create a patient
    if (params[:session][:role]).to_i == 1
      @patient = Patient.new(patient_params)
      @patient.registered=0

      if @patient.valid?
        @patient.save
        flash[:success] = "Patient Registered"
        redirect_to controller: '/staff/add_patient', action: 'new', :id => @staff.id
      else
        render 'staff/add_patient/new'
      end

    end

  end

  private
  def patient_params
    params.require(:session).permit(:full_name, :first_name, :middle_name, :last_name, :gender, :telephone, :date_of_birth)
  end
end
