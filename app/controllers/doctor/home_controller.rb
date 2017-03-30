class Doctor::HomeController < ApplicationController
  layout 'doctor'
  protect_from_forgery unless: -> { request.format.html? }

  #show doctor home
  def show
    @doctor = Doctor.find(params[:id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    render('doctors/home')
  end


end