class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to 'login/login' unless current_user
  end

  def require_admin
    redirect_to '/' unless current_user.admin?
  end

  def require_doctor
    redirect_to 'login/login' unless current_user.doctor?
  end



end
