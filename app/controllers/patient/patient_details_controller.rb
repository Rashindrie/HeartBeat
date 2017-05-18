class Patient::PatientDetailsController < ApplicationController
  layout 'application'

  before_action :confirm_logged_in
  before_action :require_patient

  #get edit patient details page
  def edit
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, gender AS gender, first_name AS first_name, middle_name AS middle_name, last_name AS last_name, full_name AS full_name, date_of_birth AS date_of_birth, telephone AS telephone, users.email AS email')
                   .where('patient_id = ?',params[:id]).first
  end

  #update patients details
  def update
    @patient = Patient.find(params[:id])

    if @patient.update_attributes(patient_params)
      flash[:success] = "Update successfull"
      redirect_to :controller => 'patient/patient_details', :action => 'edit', id: @patient.id

    else
      flash.now[:error] = "Update unsuccessful"
      @patient = Patient.joins(:user)
                     .select('patients.id AS id, gender AS gender, first_name AS first_name, middle_name AS middle_name, last_name AS last_name, full_name AS full_name, date_of_birth AS date_of_birth, telephone AS telephone, users.email AS email')
                     .where('patient_id = ?',params[:id]).first
      @id = params[:id]
      render 'patient/patient_details/edit'
    end
  end




  private
  def patient_params
    params.require(:patient).permit(:full_name, :first_name, :middle_name, :last_name,
                                    :telephone, :date_of_birth, :gender)
  end



end
