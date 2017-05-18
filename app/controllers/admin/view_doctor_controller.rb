class Admin::ViewDoctorController < ApplicationController

  layout 'application'

  #validate authorized user
  before_action :confirm_logged_in
  before_action :require_admin

  #render page to search for doctors
  def index
    @admin = User.find(params[:id])
    @doctors = Doctor.all.select('id AS id').select('full_name AS full_name').to_json
  end

  #show doctors profile
  def show
    @admin = User.find(params[:admin_id])
    @doctor=Doctor.find(params[:id])
    @doctor_type=DoctorType.where('id = ?', @doctor.doctor_type_id).pluck(:speciality)[0]
    @user=User.where('doctor_id = ?', @doctor.id )[0]

    #app_summary_by_day chart
    @sun=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('DAYOFWEEK(time_slots.app_date) = 1').count
    @mon=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('DAYOFWEEK(time_slots.app_date) = 2').count
    @tue=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('DAYOFWEEK(time_slots.app_date) = 3').count
    @wed=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('DAYOFWEEK(time_slots.app_date) = 4').count
    @thur=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('DAYOFWEEK(time_slots.app_date) = 5').count
    @fri=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('DAYOFWEEK(time_slots.app_date) = 6').count
    @sat=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('DAYOFWEEK(time_slots.app_date) = 7').count


    #app_summary_by_month
    @jan=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 1').count
    @feb=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 2').count
    @mar=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 3').count
    @apr=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 4').count
    @may=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 5').count
    @jun=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 6').count
    @jul=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 7').count
    @aug=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 8').count
    @sep=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 9').count
    @oct=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 10').count
    @nov=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 11').count
    @dec=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 12').count

  end

  #update doctor status to active or inactive
  def update

    @admin = User.find(params[:admin_id])
    @doctor=Doctor.find(params[:id])
    @user=User.find_by_doctor_id(@doctor.id)


    if @user.update_attribute(:status, params[:action_id])
      flash[:success]="Update Successfull"
      redirect_to (:back)
    else
      flash[:error]="Update Unsuccessfull"
      redirect_to (:back)
    end
  end

end
