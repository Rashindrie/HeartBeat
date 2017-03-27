class Doctor::DoctorDetailsController < ApplicationController
  layout 'doctor'

  #before_action :require_doctor, only: [:updateVital, :editVital]



  def edit
    @doctor = Doctor.find(params[:id])
    @doctor_types=DoctorType.all
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    render ('/doctors/edit')
  end

  def update
    @doctor = Doctor.find(params[:id])

    if @doctor.update_attributes(doctor_params)
      flash[:notice] = "Doctor details updated successfully."
      redirect_to :controller => 'doctor/doctor_details', :action => 'edit', id: @doctor.id

    else
      flash[:notice] = "Update unsuccessful."
      @id = params[:id]
      render :action => '/doctor/profile'
      #render('/patient/profile/<%= @patient.id %>')  #to get a prepolutaed form
    end
  end




  private

  def doctor_params
    params.require(:doctor).permit(:full_name, :first_name, :middle_name, :last_name,
                                    :telephone, :doctor_type_id, :email, :gender)
  end



end
