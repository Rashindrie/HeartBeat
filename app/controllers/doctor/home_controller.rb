class Doctor::HomeController < ApplicationController
  layout 'doctor'

  def show
    @doctor = Doctor.find(params[:id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    render('doctors/home')
  end


end