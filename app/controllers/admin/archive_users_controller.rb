class Admin::ArchiveUsersController < ApplicationController

  layout 'application'

  #validate authorized user
  before_action :confirm_logged_in
  before_action :require_admin

  #render page to view administrators
  def show
    @admin = User.find(params[:id])
    @administrators =User.where('role = ? ',0).where('id != ?', @admin.id)
  end

  #method to update administrators status
  def update
    @admin = User.find(params[:admin_id])
    @user=User.find(params[:id])

    #render success if update is successful
    if  @user.update_attribute(:status, params[:commit])
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
