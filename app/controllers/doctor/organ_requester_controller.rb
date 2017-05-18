class Doctor::OrganRequesterController < ApplicationController
  layout 'application'
  before_action :confirm_logged_in
  before_action :require_doctor

  def index
    @doctor = Doctor.find(params[:id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @organs=Organ.distinct.all
  end

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


    if (@o != -1) && @d== 1

      @searchResults =OrgansRequesterPatient
                          .includes(:organ, :patient, :doctor)
                          .where('organ_id = ?', @o)
                          .pluck('organs.name','patients.id','patients.first_name', 'patients.last_name','(organs_requester_patients.status)','doctors.first_name', 'doctors.last_name','organs_requester_patients.organ_id')

      if @searchResults.blank?
        flash.now[:notice]="No registered organ requesters for #{Organ.find(@o).name}"
      end
       render('doctor/organ_requester/index')

    elsif
    @searchResults = OrgansRequesterPatient
                         .includes(:organ, :patient, :doctor)
                         .pluck('organs.name','patients.id','patients.first_name', 'patients.last_name','(organs_requester_patients.status)','doctors.first_name', 'doctors.last_name','organs_requester_patients.organ_id')

      if @searchResults.blank?
        flash.now[:notice]="No registered organ requesters"
      end

      render('doctor/organ_requester/index')
    end

  end


  def update
    @doctor = Doctor.find(params[:doctor_id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @organs=Organ.distinct.all

    @organ_id=params[:organ_id]
    @patient_id=params[:patient_id]

    @op=Patient.find(@patient_id)
    @organ= OrgansRequesterPatient.where('patient_id = ?', @patient_id ).where('organ_id = ?', @organ_id)


    if @organ.update_all(:status => params[:id], :doctor_id => @doctor.id)

      flash[:success] = "Status Update Successful."
      redirect_to :back
    else
      flash[:error] = "Status Update unsuccessful. Please try again"
      redirect_to :back
    end

  end

end
