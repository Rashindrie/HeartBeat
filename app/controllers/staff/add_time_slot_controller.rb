class Staff::AddTimeSlotController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  #render a form to add a new timeslot
  def new
    @staff = Staff.find(params[:id])
    @doctors=Doctor.all
    @time_slot=TimeSlot.new
  end

  #add a new timeslot for a doctor
  def create
    @staff = Staff.find(params[:id])
    @time_slot=TimeSlot.new(time_slot_params)
    @doctors=Doctor.all
    @time_slot.staff_id=@staff.id
    @time_slot.status=1

    if TimeSlot.doc_time_slots(@time_slot.doctor_id, @time_slot.app_date, @time_slot.from_time, @time_slot.to_time) == 0
      if @time_slot.valid?
        @time_slot.save
        flash[:success] = "Time slot added successfully"
        redirect_to controller: '/staff/add_time_slot', action: 'new', :id => @staff.id
      else
        flash.now[:error] = "Error occurred in adding time slot. Please try again."
        render('/staff/add_time_slot/new')
        #render :text => (flash[:notice]).inspect
      end

    else
      flash.now[:error] = "Time Slot adding failed. The given time fields clash with an existing time slot."
      render('/staff/add_time_slot/new')
      #render :text => (flash[:notice]).inspect
    end

  end

  private
  def time_slot_params
    params.require(:time_slot).permit(:doctor_id, :app_date, :from_time,
                                      :to_time, :staff_id)
  end

end