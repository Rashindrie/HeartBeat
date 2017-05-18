class Admin::SignupEmpController < ApplicationController
  layout 'application'

  #validate authorized user
  before_action :confirm_logged_in
  before_action :require_admin

  #render page to add employee
  def registerEmp
    @doctor_types=DoctorType.all
    @admin = User.find(params[:id])
  end

  #render page to add admin
  def registerAdmin
    @admin = User.find(params[:id])
  end

  #add users
  def create
    @admin = User.find(params[:id])
    @user = User.new(user_params)

    #create a admin
    if (params[:session][:role]).to_i == 0
      if @user.valid?
        @user.save
          flash[:success] = "Admin Register successfull. Activation mail sent."
          @user.send_activation_email
          return redirect_to controller: '/admin/signup_emp', action: 'registerAdmin', :id => params[:id]

      else
        @doctor_types=DoctorType.all
        #flash.now[:error] = "Admin Register Unsuccessfull" when update unsuccessful
        render 'admin/signup_emp/registerAdmin'
      end

    end

    #create a doctor
    if (params[:session][:role]).to_i == 2

      @doctor = Doctor.new(doctor_params)

      @user.doctor=@doctor
      if @user.valid?
        @doctor.save
        @user.doctor_id = @doctor.id

        if @user.save
          @user.send_activation_email
          flash[:success] = "Doctor Registration successfull. Activation mail sent."

          return redirect_to controller: '/admin/signup_emp', action: 'registerEmp', :id => params[:id]
        end
      else
        @doctor_types=DoctorType.all
        #flash.now[:error] = "Registration Unsuccessfull. Please try again."
        render 'admin/signup_emp/registerEmp'
      end

    end

    #create a staffs member
    if (params[:session][:role]).to_i == 3

      @staff = Staff.new(staff_params)

      @user.staff = @staff

      if @user.valid?
        @staff.save
        @user.staff_id = @staff.id
        if @user.save
          @user.send_activation_email
          flash[:success] = "Clinical Staff Registration successfull. Activation mail sent."
          redirect_to controller: '/admin/signup_emp', action: 'registerEmp', :id => params[:id]
        end
      else
        @doctor_types=DoctorType.all
        #flash.now[:error] = "Registration Unsuccessfull. Please try again."
        render 'admin/signup_emp/registerEmp'
      end
    end


  end


 #private methods
  private
  def user_params
    params.require(:session).permit(:email, :password, :role)
  end

  def doctor_params
    params.require(:session).permit(:full_name, :first_name, :middle_name, :last_name, :gender, :telephone, :email, :doctor_type_id)
  end

  def staff_params
    params.require(:session).permit(:full_name, :first_name, :middle_name, :last_name, :gender, :telephone, :email)
  end
end

