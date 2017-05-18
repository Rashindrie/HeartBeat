class Patient::OrganRequesterController < ApplicationController

  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }
  before_action :confirm_logged_in
  before_action :require_patient

  def new
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:id]).first
    @organs=Organ.distinct.all
    #@events = TimeSlot.all
  end

  def create
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:id]).first
    @organs=Organ.distinct.all



    if params[:organ]
      @p = OrgansRequesterPatient
               .includes(:organ)
               .where('organs_requester_patients.patient_id =?', @patient.id)
               .where('organs_requester_patients.organ_id =?', params[:organ][:organ_id])

      if @p.blank?
        @organ=OrgansRequesterPatient.create(patient_id: @patient.id, organ_id: params[:organ][:organ_id].to_i, status: 0)
          @organ.save!
          flash[:success] = "Registration Successful."
          return redirect_to controller: '/patient/organ_requester', action: 'index', :id => @patient.id

      else
        flash[:error] = "Registration unsuccessful. Cannot register to organ(s)/tissues(s) if once registered for them."
        return redirect_to controller: '/patient/organ_requester', action: 'new', :id => @patient.id
      end
    else
      flash[:error] = "Please select a valid option in order to register"
      return redirect_to controller: '/patient/organ_requester', action: 'new', :id => @patient.id
    end

  end

  def index
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:id]).first


    @organ=OrgansRequesterPatient
               .includes(:organ, :doctor)
               .where('organs_requester_patients.patient_id =?', @patient.id)
               .pluck('organs.name','(organs_requester_patients.status)','doctors.first_name', 'doctors.last_name')

    #render :text => @organ.inspect



  end

end
