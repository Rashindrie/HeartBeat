class Patient::PatientDetailsController < ApplicationController
   layout 'patient'

   #before_action :require_doctor, only: [:updateVital, :editVital]

   protect_from_forgery unless: -> { request.format.html? }

   def edit
     @patient = Patient.find(params[:id])
     render ('/patients/edit')
   end

   def update
     @patient = Patient.find(User.find(session[:user_id]).patient_id)

     if @patient.update_attributes(patient_params)
       flash[:notice] = "patient updated successfully."
       redirect_to :controller => 'patient/patient_details', :action => 'edit', id: @patient.id

     else
       flash[:notice] = "Update unsuccessful."
       @id = params[:id]
       render :action => '/patient/profile'
       #render('/patient/profile/<%= @patient.id %>')  #to get a prepolutaed form
     end
   end




  private

  def patient_params
    params.require(:patient).permit(:full_name, :first_name, :middle_name, :last_name,
                                    :telephone, :date_of_birth, :email, :gender)
  end



end
