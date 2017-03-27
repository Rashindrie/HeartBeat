class Timeslot::AddAvailabilityController < ApplicationController
  layout 'staff'
  protect_from_forgery unless: -> { request.format.html? }
  def new
    @staff = Staff.find(params[:id])
    @doctors=Doctor.all
    @time_slot=TimeSlot.new
    render('time_slots/new')
  end

  def create
    @staff = Staff.find(params[:id])
    @time_slot=TimeSlot.new(time_slot_params)
    @time_slot.staff_id=(User.find(session[:user_id])).staff_id
    if @time_slot.save
      redirect_to controller: '/timeslot/add_availability', action: 'new', :id => @staff.id
    else
      render('time_slots/new')
    end
  end

  private
  def time_slot_params
      params.require(:time_slot).permit(:doctor_id, :app_date, :from_time,
                                      :to_time, :staff_id)

  end

end