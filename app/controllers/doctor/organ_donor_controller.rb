class Doctor::OrganDonorController < ApplicationController
  layout 'application'

  #validate authorized user
  before_action :confirm_logged_in
  before_action :require_doctor

  #render page to view organ donors
  def index
    @doctor = Doctor.find(params[:id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @organs=Organ.distinct.all
  end

  #search for donors
  def search
    @doctor = Doctor.find(params[:id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @organs=Organ.distinct.all

    if params[:app]
      @d=params[:app][:d].to_i
      if params[:organ]
        @o=params[:organ][:organ_id].to_i
      else
        @o=-1
      end
    else
      @d=0
    end

  #show search paramtere results
    if (@o != -1) && @d== 1
      @searchResults = OrgansDonorPatient.includes(:organ, :patient).where('organ_id = ?', @o)
                           .pluck('organs.name','patients.first_name','patients.last_name','patients.id')

      if @searchResults.blank?
        flash.now[:notice]="No registered organ donors for organ type - #{Organ.find(@o).name}"
      end
      render('doctor/organ_donor/index')

    elsif
      @searchResults = OrgansDonorPatient.includes(:organ, :patient)
                           .pluck('organs.name','patients.first_name','patients.last_name','patients.id')
      if @searchResults.blank?
        flash.now[:notice]="No registered organ donors"
      end
      render('doctor/organ_donor/index')
    end

  end

end
