class Patient::OrganDonorController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  def new
    @patient = Patient.find(params[:id])
    @blood=Organ.where('category =?', 2)
    @organ_living=Organ.where('category =?', 0).where('living_donation = ?', 1).order('name')
    @tissue_living=Organ.where('category =?', 1).where('living_donation = ?', 1).order('name')
    @organ_deceased=Organ.where('category =?', 0).where('deceased_donation = ?', 1).order('name')
    @tissue_deceased=Organ.where('category =?', 1).where('deceased_donation = ?', 1).order('name')
    #@events = TimeSlot.all


    @patient_blood=@patient.donor_organs.where('organs.category =?', 2).where('organs_donor_patients.category = ?', 1).pluck('organs.id')
    @patient_organ_living=@patient.donor_organs.where('organs.category =?', 0).where('organs_donor_patients.category = ?', 1).pluck('organs.id')
    @patient_tissue_living=@patient.donor_organs.where('organs.category =?', 1).where('organs_donor_patients.category = ?', 1).pluck('organs.id')
    @patient_organ_deceased=@patient.donor_organs.where('organs.category =?', 0).where('organs_donor_patients.category = ?', 0).pluck('organs.id')
    @patient_tissue_deceased=@patient.donor_organs.where('organs.category =?', 1).where('organs_donor_patients.category = ?', 0).pluck('organs.id')


  end

  def create
    @patient = Patient.find(params[:id])
    @p=OrgansDonorPatient.where('patient_id =?',@patient.id)

    if @p.blank?
      #no prior records for this patient.
    else
      #prior records exist
      @p.each do |d|
        @op=Patient.find(@patient.id)
        @organ=@op.donor_organs.find(d.organ_id)
        @organ=@op.donor_organs.delete(d.organ_id)
        end
    end


    #add living donations-organs
    if params[:organ_living].blank? == false

      params[:organ_living].each do |d|

        @p=OrgansDonorPatient.create(patient_id: @patient.id, organ_id: d.to_i, category: 1)
        if @p.save!

        else
          flash[:error] = "Registration unsuccessful. Please try again"
          return redirect_to controller: '/patient/organ_donor', action: 'new', :id => @patient.id
        end
      end
    end

    #add living donations-tissues
    if params[:tissue_living].blank? == false

      params[:tissue_living].each do |d|

        @p=OrgansDonorPatient.create(patient_id: @patient.id, organ_id: d.to_i, category: 1)
        if @p.save!

        else
          flash[:error] = "Registration unsuccessful. Please try again"
          return redirect_to controller: '/patient/organ_donor', action: 'new', :id => @patient.id
        end
      end
    end

    #add deceased donations-organs
    if params[:organ_deceased].blank? == false

      params[:organ_deceased].each do |d|

        @p=OrgansDonorPatient.create(patient_id: @patient.id, organ_id: d.to_i, category: 0)

        if @p.save!

        else
          flash[:error] = "Registration unsuccessful. Please try again"
          return redirect_to controller: '/patient/organ_donor', action: 'new', :id => @patient.id
        end
      end
    end

    #add deceased donations-tissue
    if params[:tissue_deceased].blank? == false

      params[:tissue_deceased].each do |d|

        @p=OrgansDonorPatient.create(patient_id: @patient.id, organ_id: d.to_i, category: 0)
        if @p.save!

        else
          flash[:error] = "Registration unsuccessful. Please try again"
          return redirect_to controller: '/patient/organ_donor', action: 'new', :id => @patient.id
        end
      end
    end

    #add living donations-blood
    if params[:organ][:blood] == "On"
      @p=OrgansDonorPatient.create(patient_id: @patient.id, organ_id: Organ.find_by_name('Blood').to_i, category: 1)
        if @p.save!

        else
          flash[:error] = "Registration unsuccessful. Please try again"
          return redirect_to controller: '/patient/organ_donor', action: 'new', :id => @patient.id
        end
    end

    flash[:success] = "Registration Successful."
    return redirect_to controller: '/patient/organ_donor', action: 'new', :id => @patient.id

  end

  private
  def organ_params
    params.require(:organ_living).permit()
  end

end
