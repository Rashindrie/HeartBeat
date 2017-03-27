class User::Signin::LoginController < ApplicationController
  layout 'application'

  def login
    # login form
    render ('login/login')
  end

  def attempt_login
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "You are now logged in"
      #redirect_to '/patient/home'


      if @user.role == 1

        redirect_to controller: '/patient/home', action: 'show', :id => @user.patient_id
      end

      if @user.role ==2
        redirect_to controller: '/doctor/home', action: 'show', :id => @user.doctor_id
      end

      if @user.role ==3
        redirect_to controller: '/staff/home', action: 'show', :id => @user.staff_id
      end


    else
      flash.now[:notice] = "Invalid username/ password combination."
      render 'login/login'
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = 'logged out'
    redirect_to('/login')
  end


end
