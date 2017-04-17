class VitalController < ApplicationController

  layout 'application'

  protect_from_forgery unless: -> { request.format.html? }

  #get patients vitals
  def show
    if current_user.doctor?
      @doctor =Doctor.find(User.find(session[:user_id]).doctor_id)
      @doctor_type = DoctorType.find(@doctor.doctor_type_id)
      @patient = Patient.find(params[:id])
      @age=age(@patient.date_of_birth)
    else
      @patient = Patient.find(User.find(session[:user_id]).patient_id)
      @age=age(@patient.date_of_birth)
    end

    @vital = Vital.order("created_at DESC").find_by_patient_id(params[:id])
    @blood_groups= {"A+" => 0, "A-" => 1, "B+" => 2, "B-" => 3, "O+" => 4, "O-" => 5}

    if @vital.nil?
      @vital=Vital.new
      @id=params[:id]
      render('/vital/show')
    else
      @edit_doctor=Doctor.find_by_id(@vital.doctor_id)
      @id=params[:id]
      render('/vital/show')
    end
  end


  #edit patients vital page
  def edit
    @doctor =Doctor.find(User.find(session[:user_id]).doctor_id)
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @patient = Patient.find(params[:id])
    @age=age(@patient.date_of_birth)
    @blood_groups= {"A+" => 0, "A-" => 1, "B+" => 2, "B-" => 3, "O+" => 4, "O-" => 5}
    @vital = Vital.order("created_at DESC").find_by_patient_id(params[:id])

    if @vital.nil?
      @vital=Vital.new
      @id=params[:id]
      render('/vital/edit')
    else
      @edit_doctor=Doctor.find_by_id(@vital.doctor_id)
      @id=params[:id]
      render('/vital/edit')
    end
  end


  #update patients vitals
  def update
    @doctor =Doctor.find(User.find(session[:user_id]).doctor_id)

    @patient = Patient.find(params[:id])
    @vital = Vital.new(vital_params)
    @vital.patient_id = params[:id]
    @vital.doctor_id =@doctor.id


    if @vital.save
      flash[:success] = "Vitals updated successfully."
      redirect_to :controller => 'vital', :action => 'show', :id => params[:id]
    else
      flash[:error] = "Update unsuccessful."
      @id = params[:id]
      redirect_to :controller => 'vital', :action => 'edit', :id => params[:id]
    end
  end


  #private methods
  private
  def vital_params
    params.require(:vital).permit(:doctor_id, :height, :weight, :bmi,
                                  :blood_group, :temp, :pulse, :res_rate, :bld_pressure )
  end

  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end