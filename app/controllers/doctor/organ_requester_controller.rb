class Doctor::OrganRequesterController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

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

       render('doctor/organ_requester/index')

    elsif
    @searchResults = OrgansRequesterPatient
                         .includes(:organ, :patient, :doctor)
                         .pluck('organs.name','patients.id','patients.first_name', 'patients.last_name','(organs_requester_patients.status)','doctors.first_name', 'doctors.last_name','organs_requester_patients.organ_id')
      render('doctor/organ_requester/index')
    end

  end


  def update
    render :text => params.inspect
  end

end
