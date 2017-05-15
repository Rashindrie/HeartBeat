class User::RegisterController < ApplicationController

  layout 'application'
  #before_action :require_user, only: [:logout, :show]
  #before_action :require_user, only: [:show, :edit, :update, :destroy]

  #before_action :require_editor, only: [:show, :edit]

  def new
    @user = User.new
  end

  def registerPatient
    @user = User.new
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

      @user.patient = @patient

      if @user.valid?
        @patient.save
        @user.patient_id = @patient.id
        if @user.save
          @user.send_activation_email
          flash[:notice] = "Please check your email to activate your account."
          redirect_to root_url
        end
      else
        #flash.now[:error] = "Signup Unsuccessfull"
        render 'user/register/registerPatient'
      end

    end

  end



  private
  def user_params
    params.require(:session).permit(:email, :password, :role, :password_confirmation)
  end

  def patient_params
    params.require(:session).permit(:full_name, :first_name, :middle_name, :last_name, :gender, :telephone, :date_of_birth)
  end

end
