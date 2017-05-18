class Staff::StaffDetailsController < ApplicationController
  layout 'application'
  before_action :confirm_logged_in
  before_action :require_staff


  def edit
    @staff = Staff.find(params[:id])
  end

  def update
    @staff = Staff.find(params[:id])

    if @staff.update_attributes(staff_params)
      flash[:success] = "Details updated successfully."
      redirect_to :controller => 'staff/staff_details', :action => 'edit', id: @staff.id

    else
      flash.now[:error] = "Update unsuccessful."
      @id = params[:id]
      render :action => '/staff/profile'
    end
  end




  private

  def staff_params
    params.require(:staff).permit(:full_name,:first_name, :middle_name, :last_name,
                                  :telephone, :gender)
  end



end
