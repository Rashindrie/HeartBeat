class Staff::HomeController < ApplicationController
  layout 'application'
  before_action :confirm_logged_in
  before_action :require_staff


  def home
    @staff = Staff.find(params[:id])
    @new_users=User.where('created_at >= ?', Date.today.to_date- 90).count
    @new_apps=Appointment.where('created_at >= ?', Date.today.to_date- 30).count
    @new_patients=User.where('role = 1').where('created_at >= ?', Date.today.to_date- 30).count
    @new_timeslots=TimeSlot.where('created_at >= ?', Date.today.to_date- 30).count

    #task-card
    @time_slot=TimeSlot.joins(:doctor).where('app_date = ?', Date.today.to_date ).select('doctors.full_name AS full_name, status AS status, from_time AS from_time, to_time AS to_time, app_date AS app_date')
  end


end