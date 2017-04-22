class User::RegisterController < ApplicationController

  layout 'application'
  #before_action :require_user, only: [:logout, :show]
  #before_action :require_user, only: [:show, :edit, :update, :destroy]

  #before_action :require_editor, only: [:show, :edit]

  def new
    @user = User.new
  end

  def registerPatient
    render ('user/register/registerPatient')
  end

  def registerEmp
    @doctor_types=DoctorType.all
  end

  def create

    @user = User.new(user_params)

    #create a patient
    if (params[:session][:role]).to_i == 1
      @patient = Patient.new(patient_params)

      if @patient.valid? && @user.valid?
        @patient.save
        @user.patient_id = @patient.id
        if @user.save
          flash[:success] = "Signup successfull"
          session[:user_id] = @user.id
          redirect_to controller: '/patient/home', action: 'home', :id => @user.patient_id
        end
      else
        flash.now[:error] = "Signup Unsuccessfull"
        render 'user/register/registerPatient'
      end

    end

    #create a doctor
    if (params[:session][:role]).to_i == 2

      @doctor = Doctor.new(doctor_params)

      if @doctor.valid? && @user.valid?
        @doctor.save
        @user.doctor_id = @doctor.id

          if @user.save
            flash[:success] = "Signup successfull"
            session[:user_id] = @user.id
            redirect_to controller: '/doctor/home', action: 'home', :id => @user.doctor_id
          end
      else
        @doctor_types=DoctorType.all
        flash.now[:error] = "Signup Unsuccessfull"
        render 'user/register/registerEmp'
      end

    end
    #create a staffs member
    if (params[:session][:role]).to_i == 3

      @staff = Staff.new(staff_params)

      if @staff.valid? && @user.valid?
        @staff.save
        @user.staff_id = @staff.id
        if @user.save
          flash[:success] = "Signup successfull"
          session[:user_id] = @user.id
          redirect_to controller: '/staff/home', action: 'home', :id => @user.staff_id
        end
      else
        @doctor_types=DoctorType.all
        flash.now[:error] = "Signup Unsuccessfull"
        render 'user/register/registerEmp'
      end
    end


  end



  private
  def user_params
    params.require(:session).permit(:email, :password, :role, :password_confirmation)
  end

  def patient_params
    params.require(:session).permit(:full_name, :first_name, :middle_name, :last_name, :gender, :telephone, :email, :date_of_birth)
  end

  def doctor_params
    params.require(:session).permit(:full_name, :first_name, :middle_name, :last_name, :gender, :telephone, :email, :doctor_type_id)
  end

  def staff_params
    params.require(:session).permit(:full_name, :first_name, :middle_name, :last_name, :gender, :telephone, :email)
  end
end
