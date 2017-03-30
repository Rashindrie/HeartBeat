class Staff::StaffDetailsController < ApplicationController
  layout 'staff'
  protect_from_forgery unless: -> { request.format.html? }


  def edit
    @staff = Staff.find(params[:id])
    render ('/staffs/edit')
  end

  def update
    @staff = Staff.find(params[:id])

    if @staff.update_attributes(staff_params)
      flash[:notice] = "Doctor details updated successfully."
      redirect_to :controller => 'staff/staff_details', :action => 'edit', id: @staff.id

    else
      flash[:notice] = "Update unsuccessful."
      @id = params[:id]
      render :action => '/staff/profile'
      #render('/patient/profile/<%= @patient.id %>')  #to get a prepolutaed form
    end
  end




  private

  def staff_params
    params.require(:staff).permit(:full_name,:first_name, :middle_name, :last_name,
                                   :telephone, :email, :gender)
  end



end
