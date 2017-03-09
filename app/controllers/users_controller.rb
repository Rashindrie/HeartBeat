class UsersController < ApplicationController
  protect_from_forgery

  #before_action :require_user, only: [:logout, :show]
  #before_action :require_user, only: [:show, :edit, :update, :destroy]

  #before_action :require_editor, only: [:show, :edit]

  def new
    @user = User.new
  end

  def index
    render('signup')
  end

  def login
    # login form
    render ('login')
  end

  def attempt_login
    @user = User.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:notice] = "You are now logged in"
      redirect_to '/'
    else
      flash.now[:notice] = "Invalid username/ password combination."
      render 'users/login'
    end
  end



  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = 'logged out'
    redirect_to('users/login')
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :role)
  end
end
