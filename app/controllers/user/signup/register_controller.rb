class User::Signup::RegisterController < ApplicationController

  layout 'application'
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
    if (params[:session][:role]).to_i == 1
            @patient = Patient.new
            @patient.full_name = params[:session][:full_name]
            @patient.first_name = params[:session][:first_name]
            @patient.middle_name = params[:session][:middle_name]
            @patient.last_name = params[:session][:last_name]
            @patient.gender = params[:session][:gender]
            @patient.date_of_birth = params[:session][:date_of_birth]
            @patient.telephone = params[:session][:telephone]
            @patient.email = params[:session][:email]

         if @patient.save
              @user.patient_id = @patient.id
              if @user.save
                session[:user_id] = @user.id
                redirect_to controller: '/patient/home', action: 'show', :id => @user.patient_id
              end
         else
           flash.now[:notice] = "Signup Unsuccessfull"
            redirect_to '/signup/patient'
         end

    end

      #create a doctor
      if (params[:session][:role]).to_i == 2

        @doctor = Doctor.new
        @doctor.full_name = params[:session][:full_name]
        @doctor.first_name = params[:session][:first_name]
        @doctor.middle_name = params[:session][:middle_name]
        @doctor.last_name = params[:session][:last_name]
        @doctor.gender = params[:session][:gender]
        @doctor.telephone = params[:session][:telephone]
        @doctor.email = params[:session][:email]
        @doctor.doctor_type_id = params[:session][:doctor_type_id]

        if @doctor.save
          @user.doctor_id = @doctor.id
          if @user.save

            session[:user_id] = @user.id
            redirect_to controller: '/doctor/home', action: 'show', :id => @user.doctor_id
          end
        else
          flash.now[:notice] = "Signup Unsuccessfull"
          redirect_to '/signup/emp'
        end

    end
              #create a staffs member
        if (params[:session][:role]).to_i == 3

          @staff = Staff.new
          @staff.full_name = params[:session][:full_name]
          @staff.first_name = params[:session][:first_name]
          @staff.middle_name = params[:session][:middle_name]
          @staff.last_name = params[:session][:last_name]
          @staff.gender = params[:session][:gender]
          @staff.telephone = params[:session][:telephone]
          @staff.email = params[:session][:email]

          if @staff.save
            @user.staff_id = @staff.id
            if @user.save

              session[:user_id] = @user.id
              redirect_to controller: '/staff/home', action: 'show', :id => @user.staff_id
            end
          else
            flash.now[:notice] = "Signup Unsuccessfull"
            redirect_to '/signup/emp'
          end
        end


 end



  private
  def user_params
    params.require(:session).permit(:email, :password, :role)
  end

  def patient_params
    params.require(:session).permit(:full_name, :first_name, :middle_name, :last_name, :gender, :telephone, :email, :date_of_birth)
  end

  def doctor_params
    params.require(:session).permit(:full_name, :first_name, :middle_name, :last_name, :gender, :telephone, :email)
  end

  def staff_params
    params.require(:session).permit(:full_name, :first_name, :middle_name, :last_name, :gender, :telephone, :email)
  end
end
