class Patient::PatientDetailsController < ApplicationController
  layout 'application'

  #before_action :require_doctor, only: [:updateVital, :editVital]

  protect_from_forgery unless: -> { request.format.html? }

  #get edit patient details page
  def edit
    @patient = Patient.find(params[:id])
  end

  #update patients details
  def update
    @patient = Patient.find(params[:id])

    if @patient.update_attributes(patient_params)
      flash[:success] = "Update successfull"
      redirect_to :controller => 'patient/patient_details', :action => 'edit', id: @patient.id

    else
      flash.now[:error] = "Update unsuccessful"
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
