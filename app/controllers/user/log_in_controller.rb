class User::LogInController < ApplicationController
  layout 'application'

  def login
    # login form
  end

  def attempt_login
    @user = User.find_by_email(params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password]) && @user.status

       if @user.activated?
         session[:user_id] = @user.id
         flash[:success] = "Logged in"
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


    else
      flash[:notice] = "Invalid username/ password combination."
      redirect_to('/login')
    end
  end

  def logout
    if logged_in?
      session[:user_id] = nil
      flash[:notice] = 'Logged out'
    end
    redirect_to('/login')
  end


end
