class PasswordResetsController < ApplicationController
  layout 'application'

  #validate authorized user
  before_action :get_user, only: [:edit, :update]
  before_action :validate_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  #render new page
  def new
  end

  #new passwors request sent by email
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:notice] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:error] = "Email address not found"
      render 'new'
    end
  end

  #render edit page to update new password
  def edit
  end

  #update password
  def update
    if password_blank?
      flash.now[:error] = "Password can't be blank"
      render 'edit'
    elsif @user.update_attributes(user_params) && @user.valid?
      if @user && @user.status

        if @user.activated?
          session[:user_id] = @user.id
          flash[:success] = "Password has been reset."
          #redirect_to '/patient/home'

          if @user.role == 0

            redirect_to controller: '/admin/home', action: 'home', :id => @user.id
          end

          if @user.role == 1

            redirect_to controller: '/patient/home', action: 'home', :id => @user.patient_id
          end

          if @user.role ==2
            redirect_to controller: '/doctor/home', action: 'home', :id => @user.doctor_id
          end

          if @user.role ==3
            redirect_to controller: '/staff/home', action: 'home', :id => @user.staff_id
          end

        else
          message  = "Account not activated. "
          message += "Check your email for the activation link."
          flash[:notice] = message
          redirect_to root_url
        end
      end
    else
      flash.now[:error] = "Passwords doesn't match"
      render 'edit'
    end
  end

  # before actions which will be done before the other methods

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def validate_user
    unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:error] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end

  private
  #white listed params
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # Returns true if password is blank.
  def password_blank?
    params[:user][:password].blank?
  end
end
