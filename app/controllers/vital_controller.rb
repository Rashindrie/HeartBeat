class VitalController < ApplicationController

  layout 'application'

  protect_from_forgery unless: -> { request.format.html? }

  #get patients vitals
  def show
    if current_user.doctor?
      @doctor =Doctor.find(params[:doctor_id])
      @doctor_type = DoctorType.find(@doctor.doctor_type_id)
      @patient = Patient.joins(:user)
                     .select('patients.id AS id, gender AS gender, telephone AS telephone, date_of_birth AS date_of_birth, first_name AS first_name,last_name AS last_name, users.email AS email')
                     .where('patient_id = ?',params[:id]).first
      @age=age(@patient.date_of_birth)
    else
      @patient = Patient.joins(:user)
                     .select('patients.id AS id,date_of_birth AS date_of_birth, full_name AS full_name, first_name AS first_name,last_name AS last_name, users.email AS email')
                     .where('patient_id = ?',params[:id]).first
      @age=age(@patient.date_of_birth)
  end
    #for vital summary chart
    @data=Vital.where(:patient_id => @patient.id)
    @bld_pr= @data.pluck(:bld_pressure)
    @temp= @data.pluck(:temp)
    @pulse= @data.pluck(:pulse)
    @res_rate= @data.pluck(:res_rate)
    @from_date= @data.order('created_at').pluck(:created_at).first
    @to_date= @data.order('created_at DESC').pluck(:created_at).first
    @array = @bld_pr.each_with_index.map { |x,i| [ i+1, x, @temp[i], @pulse[i], @res_rate[i]] }

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
    @doctor =Doctor.find(params[:doctor_id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, gender AS gender, telephone AS telephone, date_of_birth AS date_of_birth, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:id]).first
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
    @doctor =Doctor.find(params[:doctor_id])
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, gender AS gender, telephone AS telephone, date_of_birth AS date_of_birth, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:id]).first
    @vital = Vital.new(vital_params)
    @vital.patient_id = params[:id]
    @vital.doctor_id =@doctor.id


    if @vital.valid?
      @vital.save
      flash[:success] = "Vitals updated successfully."
      redirect_to :controller => 'vital', :action => 'show', :id => params[:id], :doctor_id => @doctor.id
    else
      flash.now[:error] = "Update unsuccessful."
      @doctor_type = DoctorType.find(@doctor.doctor_type_id)
      @age=age(@patient.date_of_birth)

      @blood_groups= {"A+" => 0, "A-" => 1, "B+" => 2, "B-" => 3, "O+" => 4, "O-" => 5}


      @edit_doctor=Doctor.find_by_id(@vital.doctor_id)
      @id=params[:id]
      render('/vital/edit')

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