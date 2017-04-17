class Patient::OrganRequesterController < ApplicationController

  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  def new
    @patient = Patient.find(params[:id])
    @organ=Organ.distinct.all
    #@events = TimeSlot.all
  end

  def create
    @patient=Patient.find(params[:id])

    @p = OrgansRequesterPatient
             .includes(:organ)
             .where('organs_requester_patients.patient_id =?', @patient.id)
             .where('organs_requester_patients.organ_id =?', params[:organ][:organ_id])

    if params[:organ][:organ_id].blank? == false  && @p.blank?
      @p=OrgansRequesterPatient.create(patient_id: @patient.id, organ_id: params[:organ][:organ_id].to_i, status: 0)

      if @p.save!
        flash[:success] = "Registration Successful."
        return redirect_to controller: '/patient/organ_requester', action: 'index', :id => @patient.id
      else
        flash[:error] = "Registration unsuccessful. Please try again"
        return redirect_to controller: '/patient/organ_requester', action: 'new', :id => @patient.id
      end
    else
      flash[:error] = "Registration unsuccessful. Cannot register to organ(s)/tissues(s) if once registered for them."
      return redirect_to controller: '/patient/organ_requester', action: 'new', :id => @patient.id
    end
  end

  def index
    @patient=Patient.find(params[:id])


    @organ=OrgansRequesterPatient
               .includes(:organ, :doctor)
               .where('organs_requester_patients.patient_id =?', @patient.id)
               .pluck('organs.name','(organs_requester_patients.status)','doctors.first_name', 'doctors.last_name')

    #render :text => @organ.inspect



  end

end
