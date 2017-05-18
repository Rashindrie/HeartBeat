class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception, prepend: true
  skip_before_action :verify_authenticity_token, if: -> { controller_name == 'log_in' && action_name == 'attempt_login' }
  skip_before_action :verify_authenticity_token, if: -> { controller_name == 'register' && action_name == 'create' }

  #************ Important********************
  #before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  #******************************************


  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_id!(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to '/login' unless current_user
  end

  def require_admin
    unless current_user.admin?
      flash[:notice] = "Please Log in to proceed."
      redirect_to '/login'
    end
  end

  def require_doctor
    unless current_user.doctor?
      flash[:notice] = "Please Log in to proceed."
      redirect_to '/login'
    end
  end

  def require_patient
    unless current_user.patient?
      flash[:notice] = "Please Log in to proceed."
      redirect_to '/login'
    end
  end

  def require_staff
    unless current_user.staff?
      flash[:notice] = "Please Log in to proceed."
      redirect_to '/login'
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end



  private
  # Logs out the current user.
  def log_out_user
    session.delete(:user_id)
    @current_user = nil
  end

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please Log in to proceed."
      redirect_to '/login'
    end
  end


end
