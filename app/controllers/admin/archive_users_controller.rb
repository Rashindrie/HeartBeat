class Admin::ArchiveUsersController < ApplicationController

  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  def show
    @admin = User.find(params[:id])
    @administrators =User.where('role = ? ',0)
  end


  def update
    @admin = User.find(params[:admin_id])
    @user=User.find(params[:id])

    if  @user.update_attribute(:status, params[:commit]) && @user.valid?
      flash[:success] = "Update successfull"
      redirect_to :controller => '/admin/archive_users', :action => 'show', id: @admin.id

    else
      flash.now[:error] = "Update unsuccessful"
      @administrators =User.where('role = ? ',0)

      render('/admin/archive_users/show')
    end

  end

  private
  def user_params
    params.require(:user).permit(:status)
  end
end
