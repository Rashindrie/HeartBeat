class Patient::VitalsController < ApplicationController
  layout 'patient'



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
      @doctor=Doctor.find_by_id(@vital.doctor_id)
      @id=params[:id]
      render('/vitals/show')
    end


  end

  def edit
    @patient = Patient.find(params[:id])
    @age=age(@patient.date_of_birth)
    @blood_groups= {"A+" => 0, "A-" => 1, "B+" => 2, "B-" => 3, "O+" => 4, "O-" => 5}
    @vital = Vital.order("created_at DESC").find_by_patient_id(params[:id])

    if @vital.nil?
      @vital=Vital.new
      @id=params[:id]
      render('/vitals/edit')
    else
      @doctor=Doctor.find_by_id(@vital.doctor_id)
      @id=params[:id]
      render('/vitals/edit')
    end
 end

  def update

    @vital = Vital.new(vital_params)
    @vital.patient_id = params[:id]
    @vital.doctor_id =2
    #@vital.doctor_id = user.find(session[:user_id]).doctor_id


    if @vital.save
      flash[:notice] = "patient updated successfully."

      redirect_to :controller => 'patient/vitals', :action => 'show', :id => params[:id]


    else
      flash[:notice] = "Update unsuccessful."
      @id = params[:id]
      render('/patient/vital/edit')
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
