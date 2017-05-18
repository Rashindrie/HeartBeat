class Doctor::DoctorDetailsController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  before_action :confirm_logged_in
  before_action :require_doctor

  #render form to view/edit doctor details
  def edit
    @doctor = Doctor.find(params[:id])
    @doctor_types=DoctorType.sorted
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
  end

  #update doctor details
  def update
    @doctor = Doctor.find(params[:id])

    if @doctor.update_attributes(doctor_params) && @doctor.valid?
      flash[:success] = "Details updated successfully."
      redirect_to :controller => 'doctor/doctor_details', :action => 'edit', id: @doctor.id

    else
      flash.now[:error] = "Update unsuccessful."
      @id = params[:id]

      @doctor_types=DoctorType.sorted
      @doctor_type = DoctorType.find(@doctor.doctor_type_id)
      render('/doctor/doctor_details/edit')
    end
  end




  private
  def doctor_params
    params.require(:doctor).permit(:full_name, :first_name, :middle_name, :last_name,
                                   :telephone, :doctor_type_id, :gender)
  end
end
