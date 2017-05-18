class Admin::HomeController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }
  before_action :confirm_logged_in
  before_action :require_admin

  #show doctor home
  def home
    @admin = User.find(params[:id])
    @new_users=User.where('created_at >= ?', Date.today.to_date- 90).count
    @new_apps=Appointment.where('created_at >= ?', Date.today.to_date- 30).count
    @new_patients=User.where('role = 1').where('created_at >= ?', Date.today.to_date- 30).count
    @new_timeslots=TimeSlot.where('created_at >= ?', Date.today.to_date- 30).count

    #app_total_summary_pie_chart
    @app_scheduled = Appointment.where('status = 1').count
    @app_cancelled  = Appointment.where('status = 0').count
    @wl = WaitingList.all.count

    #time_slot_total_pie_chart
    @time_slot_schedueld = TimeSlot.where('status = 1').count
    @time_slot_cancelled  = TimeSlot.where('status = 0').count

  end
end
