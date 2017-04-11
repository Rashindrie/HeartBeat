class Doctor::HomeController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  #show doctor home
  def home
    @doctor = Doctor.find(params[:id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
  end


end