class AccountActivationsController < ApplicationController

  #send account activation email
  def edit
    @user = User.find_by(email: params[:email])
    if @user && !@user.activated? && @user.authenticated?(:activation, params[:id]) && @user.status
      @user.activate
      flash.now[:success] = "Account activated. Login to continue."
      render('/user/log_in/login')

    else

      flash[:error] = "Invalid activation link"
      redirect_to root_url

    end
  end

end
