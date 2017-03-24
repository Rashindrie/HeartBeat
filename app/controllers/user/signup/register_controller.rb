class User::Signup::RegisterController < ApplicationController
  protect_from_forgery
  #before_action :require_user, only: [:logout, :show]
  #before_action :require_user, only: [:show, :edit, :update, :destroy]

  #before_action :require_editor, only: [:show, :edit]

  def new
    @user = User.new
  end

  def registerPatient
    render ('users/registerPatient')
  end

  def registerEmp
    @doctor_types=DoctorType.all
    render ('users/registerEmp')
  end

  def index
    #render('signup')
  end

  def create

    @user = User.new(user_params)

    #create a patient
    if (params[:user][:role]).to_i == 1
            @patient = Patient.new
            @patient.first_name = params[:user][:first_name]
            @patient.middle_name = params[:user][:middle_name]
            @patient.last_name = params[:user][:last_name]
            @patient.gender = params[:user][:gender]
            @patient.date_of_birth = params[:user][:date_of_birth]
            @patient.telephone = params[:user][:telephone]
            @patient.email = params[:user][:email]

         if @patient.save
              @user.patient_id = @patient.id
              if @user.save
                session[:user_id] = @user.id
                redirect_to 'patient/home'
              end
          else
            redirect_to 'users/registerPatient'
         end

    end

      #create a doctor
      if (params[:user][:role]).to_i == 2

        @doctor = Doctor.new
        @doctor.first_name = params[:user][:first_name]
        @doctor.middle_name = params[:user][:middle_name]
        @doctor.last_name = params[:user][:last_name]
        @doctor.gender = params[:user][:gender]
        @doctor.telephone = params[:user][:telephone]
        @doctor.email = params[:user][:email]
        @doctor.doctor_type_id = params[:user][:doctor_type_id]

        if @doctor.save
          @user.doctor_id = @doctor.id
          if @user.save

            session[:user_id] = @user.id
            redirect_to 'doctor/home'
          end
        else
          redirect_to 'users/registerEmp'
        end

    end
              #create a staffs member
        if (params[:user][:role]).to_i == 3

          @staff = Staff.new
          @staff.first_name = params[:user][:first_name]
          @staff.middle_name = params[:user][:middle_name]
          @staff.last_name = params[:user][:last_name]
          @staff.gender = params[:user][:gender]
          @staff.telephone = params[:user][:telephone]
          @staff.email = params[:user][:email]

          if @staff.save
            @user.staff_id = @staff.id
            if @user.save

              session[:user_id] = @user.id
              redirect_to 'staff/home'
            end
          else
            redirect_to 'users/registerEmp'
          end
        end


 end



  private
  def user_params
    params.require(:user).permit(:email, :password, :role)
  end
end
