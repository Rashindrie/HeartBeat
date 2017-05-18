class Staff::AddTimeSlotController < ApplicationController
  layout 'application'
  before_action :confirm_logged_in
  before_action :require_staff

  #render a form to add a new timeslot
  def new
    @staff = Staff.find(params[:id])
    @doctors = Doctor.all.select('id AS id').select('full_name AS full_name').to_json
    @time_slot=TimeSlot.new
  end

 #add a new timeslot for a doctor
  def create
    @staff = Staff.find(params[:id])
    @time_slot=TimeSlot.new(time_slot_params)
    @doctors = Doctor.all.select('id AS id').select('full_name AS full_name').to_json
    @time_slot.staff_id=@staff.id
    @time_slot.status=1
    @time_slot.doctor_id=params[:doctor_id]

    if TimeSlot.doc_time_slots(@time_slot.doctor_id, @time_slot.app_date, @time_slot.from_time, @time_slot.to_time) == 0
      if @time_slot.valid?
        @time_slot.save
        flash[:success] = "Time slot added successfully"
        redirect_to controller: '/staff/add_time_slot', action: 'new', :id => @staff.id
      else
        #flash.now[:error] = "Error occurred in adding time slot. Please try again."
        render('/staff/add_time_slot/new')
      end

    else
      flash.now[:error] = "Time Slot adding failed. The given time fields clash with an existing time slot."
      render('/staff/add_time_slot/new')
    end

  end

  private
  def time_slot_params
    params.require(:time_slot).permit(:doctor_id, :app_date, :from_time,
                                      :to_time, :staff_id, :price)
  end

end