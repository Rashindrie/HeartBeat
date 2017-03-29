class Doctor::VitalsController < ApplicationController
  layout 'doctor'


  protect_from_forgery unless: -> { request.format.html? }
  def show
    @doctor =Doctor.find(User.find(session[:user_id]).doctor_id)
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
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
      render('/vitals/edit')
    else
      @edit_doctor=Doctor.find_by_id(@vital.doctor_id)
      @id=params[:id]
      render('/vitals/edit')
    end
  end

  def update
    @doctor =Doctor.find(User.find(session[:user_id]).doctor_id)

    @patient = Patient.find(params[:id])
    @vital = Vital.new(vital_params)
    @vital.patient_id = params[:id]
    @vital.doctor_id =@doctor.id


    if @vital.save
      flash[:notice] = "patient updated successfully."

      redirect_to :controller => 'doctor/vitals', :action => 'show', :id => params[:id]


    else
      flash[:notice] = "Update unsuccessful."
      @id = params[:id]
      redirect_to :controller => 'doctor/vitals', :action => 'edit', :id => params[:id]
      #render('/')  #to get a prepolutaed form
    end
  end

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
