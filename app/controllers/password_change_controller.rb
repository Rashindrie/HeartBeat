class PasswordChangeController < ApplicationController
  layout 'application'

  #validate authorized user
  before_action :get_user, only: [:new, :update]
  before_action :validate_user, only: [:new, :update]
  before_action :confirm_logged_in
  before_action :require_user

  #render page to create new requests
  def new
    if @user.role == 1
      @patient = Patient.joins(:user)
                     .select('patients.id AS id, first_name AS first_name,last_name AS last_name, users.email AS email')
                     .where('patient_id = ?',@user.patient_id).first
    elsif @user.role == 2
      @doctor=Doctor.find(@user.doctor_id)
      @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    elsif @user.role == 3
      @staff=Staff.find(@user.staff_id)
    else @user.role == 0
      @admin=@user
    end
  end

  #update requests
  def update
    if @user.role == 1
      @patient = Patient.joins(:user)
                     .select('patients.id AS id, first_name AS first_name,last_name AS last_name, users.email AS email')
                     .where('patient_id = ?',@user.patient_id).first
    elsif @user.role == 2
      @doctor=Doctor.find(@user.doctor_id)
      @doctor_type = DoctorType.find(@doctor.doctor_type_id)
    elsif @user.role == 3
      @staff=Staff.find(@user.staff_id)
    else @user.role == 0
      @admin=@user
    end

    if @user.authenticate(params[:user][:current_password])
      if params[:user][:password].empty?
        flash.now[:error] = "New Password can't be blank."
        render 'new'
      elsif @user.update_attributes(user_params)  && @user.valid?
        flash.now[:success] = "Password has been reset."
        render 'new'
      else
          render 'new'
      end
    else
      flash.now[:error] = "Incorrect current password"
      render 'new'
    end

  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # Before filters

  def get_user
    @user = User.find(session[:user_id])
  end

  # Confirms a valid user.
  def validate_user
    unless (@user && @user.activated? && current_user )
      render 'user/log_in/login'
    end
  end



end
