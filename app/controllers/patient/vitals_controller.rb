class Patient::VitalsController < ApplicationController
  layout 'patient'
  protect_from_forgery unless: -> { request.format.html? }


  #show patient vitals
  def show
    @patient = Patient.find(params[:id])
    @age=age(@patient.date_of_birth)
    @vital = Vital.order("created_at DESC").find_by_patient_id(params[:id])
    @blood_groups= {"A+" => 0, "A-" => 1, "B+" => 2, "B-" => 3, "O+" => 4, "O-" => 5}

    if @vital.nil?
      @vital=Vital.new
      @id=params[:id]
      render('/vitals/show')
    else
      @edit_doctor=Doctor.find_by_id(@vital.doctor_id)
      @id=params[:id]
      render('/vitals/show')
    end
  end


  private
  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end
